class EngineRunningTimeReading < AbstractIntervalModel
  PARENT_MODEL = Engine
  CUSTOM_NAME = 'Engine cummulative running hours readings'
  COUNTER_VALUES_COLUMNS = [
    {
     counter_value_column_name: :counter_value,
     type: :relative,
     absolute_value_column_name: :elapsed_hours,
     maximum_interval_difference: 24,
     minimum_interval_difference: 0
    }
  ]
  INTERVAL_IN_MINUTES = 1440
  INTERVAL_USER_INTERFACE_OFFSET = 0
  EXPORTER_CONFIG = {
    match_key_types_fragments: [],
    mappings: [
      {
        query: {
          type: :aggregate,
          fragment: 'max(counter_value) as counter_value_max,'\
                    'sum(elapsed_hours) as elapsed_hours_sum'
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
    numericality: {
      greater_than_or_equal_to: 0,
      less_than: (24*365*20) # TODO: get real counter value max value
    }
  }
end
