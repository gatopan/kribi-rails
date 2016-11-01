class PlantGrossCapacityReading < AbstractIntervalModel
  PARENT_MODEL = Plant
  CUSTOM_NAME = nil
  COUNTER_VALUES_COLUMNS = [
    {
      name: :output_capacity,
      type: :absolute,
    }
  ]
  INTERVAL_IN_MINUTES = 5
  INTERVAL_USER_INTERFACE_OFFSET = 0
  INTERVAL_USER_INTERFACE_MODE = :point
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

  validates :output_capacity, {
    presence: true,
    format: {
      with: /\A[0-9]+\.[0-9]{1}\Z/,
      message: 'must contain a decimal place'
    },
    numericality: {
      greater_than_or_equal_to: 0.0,
      less_than: 221 / 3
    }
  }
end
