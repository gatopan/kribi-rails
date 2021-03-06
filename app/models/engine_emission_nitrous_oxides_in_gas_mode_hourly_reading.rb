class EngineEmissionNitrousOxidesInGasModeHourlyReading < AbstractIntervalModel
  PARENT_MODEL = Engine
  CUSTOM_NAME = 'Engine emission Nox in gas mode hourly readings'
  COUNTER_VALUES_COLUMNS = [
    {
     name: :nitrogen_oxides_in_gas_mode,
     type: :absolute,
    }
  ]
  INTERVAL_IN_MINUTES = 60
  INTERVAL_USER_INTERFACE_OFFSET = 60
  INTERVAL_USER_INTERFACE_MODE = :vector
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
          worksheet_name: 'emission_nox_in_gas_mode_hourly'
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
          worksheet_name: 'emission_nox_in_gas_mode_hourly'
        }
      }
    ]
  }

  abstract_bootloader()

  enum nitrogen_oxides_in_gas_mode_code: {
    'OK' => 0,
    '(-)=out of operate' => 10,
    '(X)=no daily class' => 20,
    '(W)=maintenance' => 30,
    '(S)=Failure' => 40,
    '(E)=replacement value' => 50,
    '(T)=>DLV' => 60,
    '(<)=<2/3' => 70,
    '(G)=>LV' => 80,
    '(D)=>2,0 LV' => 90,
    '(N)=NoData' => 100
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
