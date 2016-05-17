class EngineLightFuelOilReading < AbstractIntervalModel
  PARENT_MODEL = Engine
  COUNTER_VALUES_COLUMNS = [
    {
     type: :relative,
     counter_value_column_name: :inlet_counter_value,
     absolute_value_column_name: :inlet_volume,
     maximum_interval_difference: 4000,
     minimum_interval_difference: 0.0
    },
    {
     type: :relative,
     counter_value_column_name: :outlet_counter_value,
     absolute_value_column_name: :outlet_volume,
     maximum_interval_difference: 4000,
     minimum_interval_difference: 0.0
    }
  ]
  INTERVAL_IN_MINUTES = 60
  EXPORTER_CONFIG = {
    match_key_types_fragments: [],
    mappings: [
      {
        query: {
          type: :aggregate,
          fragment: 'max(inlet_counter_value) as inlet_counter_value_max,'\
                    'sum(inlet_volume) as inlet_volume_sum,'\
                    'max(outlet_counter_value) as outlet_counter_value_max,'\
                    'sum(outlet_volume) as outlet_volume_sum,'\
                    'sum(consumption) as consumption_sum'
        },
        destination: {
          type: :excel,
          template: false,
          filename_prefix: "kpp_kpi_report",
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
    self.consumption = calculated_consumption
  end

  validates :inlet_counter_value, {
    presence: true,
    numericality: {
      greater_than_or_equal_to: 0.0,
      less_than: 9999999.9
    },
    format: {
      with: /\A[0-9]+\.[0-9]{1}\Z/,
      message: 'must contain a decimal place'
    }
  }
  validates :outlet_counter_value, {
    presence: true,
    numericality: {
      greater_than_or_equal_to: 0.0,
      less_than: 9999999.9
    },
    format: {
      with: /\A[0-9]+\.[0-9]{1}\Z/,
      message: 'must contain a decimal place'
    }
  }

  validate :consumption_congruence, on: :congruence

  private

  # TODO: Smells
  def calculated_consumption
    return unless inlet_counter_value
    return unless outlet_counter_value
    difference(:inlet_counter_value) - difference(:outlet_counter_value)
  end

  def consumption_congruence
    return false unless calculated_consumption

    # TODO: Migrate to base error
    if calculated_consumption < 0
      errors.add :outlet_counter_value, 'cannot be less than zero'
    end

    # TODO: Migrate to base error
    if calculated_consumption > 500
      errors.add :outlet_counter_value, 'is not congruent with consumption'
    end
  end
end
