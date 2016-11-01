class PlantReferenceConditionReading < AbstractIntervalModel
  PARENT_MODEL = Plant
  CUSTOM_NAME = nil
  COUNTER_VALUES_COLUMNS = [
    {
      name: :methane_number_at_actual_site_condition,
      type: :absolute,
    }
  ]
  INTERVAL_IN_MINUTES = 1440
  INTERVAL_USER_INTERFACE_OFFSET = 0
  INTERVAL_USER_INTERFACE_MODE = :point
  EXPORTER_CONFIG = {
    match_key_types_fragments: [],
    mappings: [
      {
        query: {
          type: :aggregate,
          fragment: 'avg(methane_number_at_actual_site_condition) as methane_number_at_actual_site_condition_avg'
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

  validates :methane_number_at_actual_site_condition, {
    presence: true,
    format: {
      with: /\A[0-9]+\.[0-9]{1}\Z/,
      message: 'must contain a decimal place'
    },
    numericality: {
      greater_than_or_equal_to: 60.0,
      less_than: 80.1
    }
  }
end
