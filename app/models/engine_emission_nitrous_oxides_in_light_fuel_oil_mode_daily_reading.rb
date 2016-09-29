class EngineEmissionNitrousOxidesInLightFuelOilModeDailyReading < AbstractIntervalModel
  PARENT_MODEL = Engine
  CUSTOM_NAME = nil
  COUNTER_VALUES_COLUMNS = [
    {
     name: :nitrogen_oxides_in_light_fuel_oil_mode,
     type: :absolute,
    }
  ]
  INTERVAL_IN_MINUTES = 60 * 24
  EXPORTER_CONFIG = {
    match_key_types_fragments: [],
    mappings: [
      {
        query: {
          type: :aggregate,
          fragment: 'sum(nitrogen_oxides_in_light_fuel_oil_mode) as nitrogen_oxides_in_light_fuel_oil_mode_sum'
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


  enum nitrogen_oxides_in_light_fuel_oil_mode_code: {
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

  validates :nitrogen_oxides_in_light_fuel_oil_mode, {
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
  validates :nitrogen_oxides_in_light_fuel_oil_mode_code, presence: true
end
