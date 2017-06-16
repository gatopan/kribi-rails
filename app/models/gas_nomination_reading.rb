class GasNominationReading < AbstractIntervalModel
  PARENT_MODEL = GasPressureReducingStation
  CUSTOM_NAME = 'Gas contractual readings'
  COUNTER_VALUES_COLUMNS = [
    {
     name: :nomination,
     type: :absolute,
    },
    {
     name: :delivery,
     type: :absolute,
    },
    {
     name: :high_heating_value,
     type: :absolute,
    },
    {
     name: :contractual_methane_number,
     type: :absolute,
    }
  ]
  INTERVAL_IN_MINUTES = 1440
  INTERVAL_USER_INTERFACE_OFFSET = 60 * 6
  INTERVAL_USER_INTERFACE_MODE = :vector
  EXPORTER_CONFIG = {
    match_key_types_fragments: [],
    mappings: [
      {
        query: {
          type: :aggregate,
          fragment: 'sum(nomination) as nomination_sum,'\
                    'sum(delivery) as delivery,'\
                    'sum(high_heating_value) as high_heating_value_sum,'\
                    'avg(contractual_methane_number) as contractual_methane_number_average'
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

  before_validation do
    self.quality = calculated_quality
  end

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
  validates :delivery, {
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
  validates :contractual_methane_number, {
    presence: true,
    numericality: {
      greater_than_or_equal_to: 60,
      less_than_or_equal_to: 80
    },
    format: {
      with: /\A[0-9]+\.[0-9]{1,3}\Z/,
      message: 'must contain up to three decimal places'
    }
  }

  def calculated_quality
    return unless delivery

    if delivery >= 1000 && delivery <= 1185
      'ON-SPEC'
    else
      'OFF-SPEC'
    end
  end
end
