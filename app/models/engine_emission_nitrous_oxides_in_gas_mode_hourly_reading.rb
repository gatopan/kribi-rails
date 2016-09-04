class EngineEmissionNitrousOxidesInGasModeHourlyReading < AbstractIntervalModel
  PARENT_MODEL = Engine
  COUNTER_VALUES_COLUMNS = [
    {
     name: :nitrogen_oxides_in_gas_mode,
     type: :absolute,
    }
  ]
  INTERVAL_IN_MINUTES = 60
  EXPORTER_CONFIG = {
    match_key_types_fragments: [],
    mappings: [
      {
        query: {
          type: :aggregate,
          fragment: 'sum(nitrogen_oxides_in_gas_mode) as nitrogen_oxides_in_gas_mode_sum'
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

  enum nitrogen_oxides_in_gas_mode_code: {
    OK: 0,
    OUT_OF_OPERATE: 1,
    NO_DAILY_CLASS: 2,
    MAINTENANCE: 3,
    FAILURE: 4,
    REPLACEMENT_VALUE: 5,
    MORE_THAN_DLV: 6,
    LESS_THAN_TWO_THIRDS: 7,
    MORE_THAN_LV: 8,
    MORE_THAN_TWO_ZERO_LV: 9,
    NO_DATA: 10
  }

  validates :nitrogen_oxides_in_gas_mode, {
    presence: true,
    numericality: {
      greater_than_or_equal_to: 0,
      less_than_or_equal_to: 99999.999
    },
    format: {
      with: /\A[0-9]+\.[0-9]{1,3}\Z/,
      message: 'must contain up to three decimal places'
    }
  }
  validates :nitrogen_oxides_in_gas_mode_code, presence: true
end
