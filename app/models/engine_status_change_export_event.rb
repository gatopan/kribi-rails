class EngineStatusChangeExportEvent < AbstractEventModel
  self.inheritance_column = nil
  PARENT_MODEL = Engine
  CUSTOM_NAME = nil
  EXPORTER_CONFIG = {
    match_key_types_fragments: [:engine_mode, :derating_mode],
    mappings: [
      {
        query: {
          type: :aggregate,
          fragment: 'sum(duration_in_hours) as duration_in_hours_sum'
        },
        destination: {
          type: :excel,
          template: false,
          filename_prefix: 'kpp_kpi_report',
          worksheet_name: self.table_name
        }
      },
      {
        query: {
          type: :dump,
        },
        destination: {
          type: :excel,
          template: false,
          filename_prefix: "#{self.table_name}_dump",
          worksheet_name: self.table_name
        }
      }
    ]
  }
  abstract_bootloader()

  enum type: {
    INTERNAL: 0,
    DECLARED: 1,
    FORECASTED: 2
  }

  enum engine_mode: {
    IN_SERVICE: 0, # NO_DERATING, PLANNED_DERATING, FORCED_DERATING
    RESERVED: 1, # NO_DERATING, RESERVED_DERATING
    SCHEDULED_OUTAGE: 2, # NO_DERATING
    MANUAL_FORCED_OUTAGE: 3, # NO_DERATING
    AUTOMATIC_FORCED_OUTAGE: 4 # NO_DERATING
  }

  enum derating_mode: {
    NO_DERATING: 0,
    RESERVED_DERATING: 1,
    PLANNED_DERATING: 2,
    FORCED_DERATING: 3
  }

  enum resolution_department: {
    NONE: 0,
    ELECTRICAL_MAINTENANCE: 1,
    MECHANICAL_MAINTENANCE: 2,
    OPERATIONS: 3,
    CONTRACTOR: 4,
    OPERATION_AND_ELECTRICAL_MAINTENANCE: 5,
    OPERATION_AND_MECHANICAL_MAINTENANCE: 6,
    OPERATION_AND_CONTRACTORS: 7,
    ELECTRICAL_MAINTENANCE_AND_MECHANICAL_MAINTENANCE: 8,
    MECHANICAL_MAINTENANCE_AND_CONTRACTORS: 9,
    ELECTRICAL_MAINTENANCE_AND_CONTRACTORS: 10,
  }

  validates :type, presence: true
  validates :engine_mode, presence: true
  validates :derating_mode, presence: true
  validates :load_limitation, {
    presence: true,
    numericality: {
      greater_than_or_equal_to: 0.0,
      less_than_or_equal_to: 16621.0
    },
    format: {
      with: /\A[0-9]+\.[0-9]{1}\Z/,
      message: 'must contain a decimal place'
    }
  }
  validates :resolution_department, presence: true

  validate :derating_congruence, on: :congruence
  validate :load_limitation_congruence, on: :congruence

  private

  def outage?
    return unless engine_mode
    ['SCHEDULED_OUTAGE', 'MANUAL_FORCED_OUTAGE', 'AUTOMATIC_FORCED_OUTAGE'].include? engine_mode
  end

  def derating?
    return unless derating_mode
    derating_mode != 'NO_DERATING'
  end

  def derating_congruence
    return unless derating_mode
    return unless engine_mode
    if outage? && derating?
      errors.add :derating_mode, 'cannot be derating because engine is already unavailable'
    end
    if (engine_mode == 'RESERVED') && ['PLANNED_DERATING', 'FORCED_DERATING'].include?(derating_mode)
      errors.add :derating_mode, 'cannot be planned or forced because engine is in reserve'
    end
    if (engine_mode == 'IN_SERVICE') && ['RESERVED_DERATING'].include?(derating_mode)
      errors.add :derating_mode, 'cannot be reserved because engine is in service'
    end
  end

  def load_limitation_congruence
    return unless load_limitation
    if derating?
      if load_limitation == 0
        errors.add :load_limitation, 'must be within 1 and 16621 if derating'
      end
    else
      unless load_limitation == 0
        errors.add :load_limitation, 'must be 0 if no derating'
      end
    end
  end
end
