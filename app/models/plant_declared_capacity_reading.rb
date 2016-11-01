class PlantDeclaredCapacityReading < AbstractIntervalModel
  PARENT_MODEL = Plant
  CUSTOM_NAME = nil
  COUNTER_VALUES_COLUMNS = [
    {
      name: :capacity_at_actual_site_conditions,
      type: :absolute,
    },
    {
      name: :capacity_at_reference_site_conditions,
      type: :absolute,
    }
  ]
  INTERVAL_IN_MINUTES = 60
  INTERVAL_USER_INTERFACE_OFFSET = 0
  INTERVAL_USER_INTERFACE_MODE = :point
  EXPORTER_CONFIG = {
    match_key_types_fragments: [],
    mappings: [
      {
        query: {
          type: :aggregate,
          fragment: 'sum(capacity_at_actual_site_conditions) as capacity_at_actual_site_conditions_sum,'\
                    'sum(capacity_at_reference_site_conditions) as capacity_at_reference_site_conditions_sum'
        },
        destination: {
          type: :excel,
          template: false,
          filename_prefix: 'kpp_kpi_report',
          worksheet_name: 'plant_declared_readings'
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
          worksheet_name: 'plant_declared_readings'
        }
      }
    ]
  }

  abstract_bootloader()

  enum grid_disturbances: {
    'NO' => 0,
    'YES' => 10
  }

  validates :capacity_at_actual_site_conditions, {
    presence: true,
    format: {
      with: /\A[0-9]+\.[0-9]{1}\Z/,
      message: 'must contain a decimal place'
    },
    numericality: {
      greater_than_or_equal_to: 0.0,
      less_than: 220.1
    }
  }
  validates :capacity_at_reference_site_conditions, {
    presence: true,
    format: {
      with: /\A[0-9]+\.[0-9]{1}\Z/,
      message: 'must contain a decimal place'
    },
    numericality: {
      greater_than_or_equal_to: 0.0,
      less_than: 220.1
    }
  }
end
