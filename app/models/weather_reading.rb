class WeatherReading < AbstractIntervalModel
  PARENT_MODEL = WeatherStation
  COUNTER_VALUES_COLUMNS = [
    {
      name: :ambient_temperature,
      type: :absolute,
    },
    {
      name: :absolute_humidity,
      type: :absolute,
    },
    {
      name: :relative_humidity,
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
          fragment: 'avg(ambient_temperature) as ambient_temperature_avg,'\
                    'avg(absolute_humidity) as absolute_humidity_avg,'\
                    'avg(relative_humidity) as relative_humidity_avg'
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

  validates :ambient_temperature, {
    presence: true,
    numericality: {
      greater_than_or_equal_to: 0.0,
      less_than: 100
    },
    format: {
      with: /\A[0-9]+\.[0-9]{1}\Z/,
      message: 'must contain one decimal place'
    }
  }
  validates :absolute_humidity, {
    presence: true,
    numericality: {
      greater_than_or_equal_to: 0.0,
      less_than: 100
    },
    format: {
      with: /\A[0-9]+\.[0-9]{1}\Z/,
      message: 'must contain one decimal place'
    }
  }
  validates :relative_humidity, {
    presence: true,
    numericality: {
      greater_than_or_equal_to: 0.0,
      less_than: 100
    },
    format: {
      with: /\A[0-9]+\.[0-9]{1}\Z/,
      message: 'must contain one decimal place'
    }
  }
end
