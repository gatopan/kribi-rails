class EngineEnergyHourlyReading < AbstractIntervalModel
  PARENT_MODEL = Engine
  CUSTOM_NAME = nil
  COUNTER_VALUES_COLUMNS = [
    {
     type: :relative,
     counter_value_column_name: :counter_value,
     absolute_value_column_name: :energy_volume,
     maximum_interval_difference: 16.5,
     minimum_interval_difference: 0.0
    }
  ]
  INTERVAL_IN_MINUTES = 60
  INTERVAL_USER_INTERFACE_OFFSET = 60
  INTERVAL_USER_INTERFACE_MODE = :point
  EXPORTER_CONFIG = {
    match_key_types_fragments: [],
    mappings: [
      {
        query: {
          type: :aggregate,
          fragment: 'max(counter_value) as counter_value_max,'\
                    'sum(energy_volume) as energy_volume_sum'
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

  validates :counter_value, {
    presence: true,
    format: {
      with: /\A[0-9]+\.[0-9]{1}\Z/,
      message: 'must contain a decimal place'
    }
  }

  validates :counter_value, {
    numericality: {
      greater_than_or_equal_to: 0,
      less_than_or_equal_to: 1E6
    },
    on: :congruence
  }
end
