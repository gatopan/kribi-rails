class GasNominationReading < AbstractIntervalModel
  PARENT_MODEL = GasPressureReducingStation
  CUSTOM_NAME = nil
  COUNTER_VALUES_COLUMNS = [
    {
     name: :nomination,
     type: :absolute,
    },
    {
     name: :delivery_on_specification,
     type: :absolute,
    },
    {
     name: :delivery_off_specification,
     type: :absolute,
    },
    {
     name: :high_heating_value,
     type: :absolute,
    }
  ]
  INTERVAL_IN_MINUTES = 1440
  EXPORTER_CONFIG = {
    match_key_types_fragments: [],
    mappings: [
      {
        query: {
          type: :aggregate,
          fragment: 'sum(nomination) as nomination_sum,'\
                    'sum(delivery_on_specification) as delivery_on_specification_sum,'\
                    'sum(delivery_off_specification) as delivery_off_specification_sum'
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

  validates :nomination, {
    presence: true,
    numericality: {
      greater_than_or_equal_to: 0,
      less_than_or_equal_to: 45000
    },
    format: {
      with: /\A[0-9]+\.[0-9]{1,3}\Z/,
      message: 'must contain up to three decimal places'
    }
  }
  validates :delivery_on_specification, {
    presence: true,
    numericality: {
      greater_than_or_equal_to: 0,
      less_than_or_equal_to: 45000
    },
    format: {
      with: /\A[0-9]+\.[0-9]{1,3}\Z/,
      message: 'must contain up to three decimal places'
    }
  }
  validates :delivery_off_specification, {
    presence: true,
    numericality: {
      greater_than_or_equal_to: 0,
      less_than_or_equal_to: 45000
    },
    format: {
      with: /\A[0-9]+\.[0-9]{1,3}\Z/,
      message: 'must contain up to three decimal places'
    }
  }
  validates :high_heating_value, {
    presence: true,
    numericality: {
      greater_than_or_equal_to: 0,
      less_than_or_equal_to: 2000
    },
    format: {
      with: /\A[0-9]+\.[0-9]{1,3}\Z/,
      message: 'must contain up to three decimal places'
    }
  }
end
