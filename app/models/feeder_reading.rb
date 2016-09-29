class FeederReading < AbstractIntervalModel
  PARENT_MODEL = Feeder
  CUSTOM_NAME = nil
  COUNTER_VALUES_COLUMNS = [
    {
      type: :relative,
      counter_value_column_name: :transmitting_counter_value,
      absolute_value_column_name: :transmitting_energy_volume,
      maximum_interval_difference: 49.5,
      minimum_interval_difference: 0.0
    },
    {
      type: :relative,
      counter_value_column_name: :receiving_counter_value,
      absolute_value_column_name: :receiving_energy_volume,
      maximum_interval_difference: 49.5,
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
          fragment: 'max(transmitting_counter_value) as transmitting_counter_value_max,'\
                    'sum(transmitting_energy_volume) as transmitting_energy_volume_sum,'\
                    'max(receiving_counter_value) as receiving_counter_value_max,'\
                    'sum(receiving_energy_volume) as receiving_energy_volume_sum'
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

  validates :receiving_counter_value, {
    presence: true,
    format: {
      with: /\A[0-9]+\.[0-9]{1}\Z/,
      message: 'must contain a decimal place'
    }
  }

  validates :receiving_counter_value, {
    numericality: {
      greater_than_or_equal_to: 0.0,
      less_than: 9999999.9
    },
    unless: Proc.new{|feeder_reading| feeder_reading.feeder_id == 4}
  }

  validates :receiving_counter_value, {
    numericality: {
      greater_than_or_equal_to: 0.0,
      less_than: 999999.9
    },
    if: Proc.new{|feeder_reading| feeder_reading.feeder_id == 4}
  }

  validates :transmitting_counter_value, {
    presence: true,
    format: {
      with: /\A[0-9]+\.[0-9]{1}\Z/,
      message: 'must contain a decimal place'
    }
  }

  validates :transmitting_counter_value, {
    numericality: {
      greater_than_or_equal_to: 0.0,
      less_than: 9999999.9
    },
    unless: Proc.new{|feeder_reading| feeder_reading.feeder_id == 4}
  }

  validates :transmitting_counter_value, {
    numericality: {
      greater_than_or_equal_to: 0.0,
      less_than: 999999.9
    },
    if: Proc.new{|feeder_reading| feeder_reading.feeder_id == 4}
  }
end
