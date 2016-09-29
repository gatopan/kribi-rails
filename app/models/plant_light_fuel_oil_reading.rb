class PlantLightFuelOilReading < AbstractIntervalModel
  PARENT_MODEL = Plant
  CUSTOM_NAME = nil
  COUNTER_VALUES_COLUMNS = [
    {
     type: :relative,
     counter_value_column_name: :inlet_hall_a_counter_value,
     absolute_value_column_name: :inlet_hall_a_liters,
     maximum_interval_difference: 5000.0,
     minimum_interval_difference: 0.0
    },
    {
     type: :relative,
     counter_value_column_name: :inlet_hall_b_counter_value,
     absolute_value_column_name: :inlet_hall_b_liters,
     maximum_interval_difference: 5000.0,
     minimum_interval_difference: 0.0
    },
    {
     type: :relative,
     counter_value_column_name: :outlet_counter_value,
     absolute_value_column_name: :outlet_cubic_meters,
     maximum_interval_difference: 10.0,
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
          fragment: 'max(inlet_hall_a_counter_value) as inlet_hall_a_counter_value_max,'\
                    'sum(inlet_hall_a_liters) as inlet_hall_a_liters_sum,'\
                    'max(inlet_hall_b_counter_value) as inlet_hall_b_counter_value_max,'\
                    'sum(inlet_hall_b_liters) as inlet_hall_b_liters_sum,'\
                    'max(outlet_counter_value) as outlet_counter_value_max,'\
                    'sum(outlet_cubic_meters) as outlet_cubic_meters_sum,'\
                    'sum(consumption_liters) as consumption_liters_sum'
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
    self.consumption_liters = calculated_consumption_liters
  end

  validates :inlet_hall_a_counter_value, {
    presence: true,
    numericality: {
      greater_than_or_equal_to: 0,
      less_than_or_equal_to: 9999999.9
    },
    format: {
      with: /\A[0-9]+\.[0-9]{1}\Z/,
      message: 'must contain one decimal place'
    }
  }

  validates :inlet_hall_b_counter_value, {
    presence: true,
    numericality: {
      greater_than_or_equal_to: 0,
      less_than_or_equal_to: 9999999.9
    },
    format: {
      with: /\A[0-9]+\.[0-9]{1}\Z/,
      message: 'must contain one decimal place'
    }
  }

  validates :outlet_counter_value, {
    presence: true,
    numericality: {
      greater_than_or_equal_to: 0,
      less_than_or_equal_to: 9999999.9
    },
    format: {
      with: /\A[0-9]+\.[0-9]{1}\Z/,
      message: 'must contain one decimal place'
    }
  }

  validate :consumption_liters_congruence, on: :congruence

  private

  def calculated_consumption_liters
    return unless inlet_hall_a_counter_value
    return unless inlet_hall_b_counter_value
    return unless outlet_counter_value
    difference(:inlet_hall_a_counter_value) + difference(:inlet_hall_b_counter_value) - (difference(:outlet_counter_value) * 1000)
  end

  def consumption_liters_congruence
    return false unless calculated_consumption_liters

    if calculated_consumption_liters < 0
      errors.add :outlet_counter_value, 'cannot be less than zero'
    end

    unless calculated_consumption_liters <= 50700
      errors.add :outlet_counter_value, 'is not congruent with consumption liters'
    end
  end
end
