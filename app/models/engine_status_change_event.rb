class EngineStatusChangeEvent < AbstractEventModel
  PARENT_MODEL = Engine
  CUSTOM_NAME = nil
  EXPORTER_CONFIG = {
    match_key_types_fragments: [],
    mappings: [
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
  CALCULATED_FIELD_NAMES = [
    'duration_in_hours'
  ]
  abstract_bootloader()

  enum engine_mode: {
    IN_SERVICE: 0, # NO_DERATING, PLANNED_DERATING, FORCED_DERATING
    RESERVED: 1, # NO_DERATING
    SCHEDULED_OUTAGE: 2, # NO_DERATING
    FORCED_OUTAGE: 3, # NO_DERATING
  }

  enum derating_mode: {
    NO_DERATING: 0,
    PLANNED_DERATING: 2,
    FORCED_DERATING: 3
  }

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

  validate :derating_congruence, on: :congruence
  validate :load_limitation_congruence, on: :congruence

  after_save :set_duration_on_previous_record

  private

  def set_duration_on_previous_record
    return unless previous_record
    duration_in_hours = (target_datetime.to_datetime - previous_record.target_datetime.to_datetime).to_f * 24
    previous_record.update(duration_in_hours: duration_in_hours)
  end

  def outage?
    return unless engine_mode
    ['SCHEDULED_OUTAGE', 'FORCED_OUTAGE'].include? engine_mode
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
    # if (engine_mode == 'IN_SERVICE') && ('RESERVED_DERATING' == derating_mode)
    #   errors.add :derating_mode, 'cannot be reserved because engine is in service'
    # end
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
