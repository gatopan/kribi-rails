class PlantDeclaredCapacityReading < AbstractIntervalModel
  PARENT_MODEL = Plant
  CUSTOM_NAME = nil
  COUNTER_VALUES_COLUMNS = [
    {
      name: :capacity_at_actual_site_conditions,
      type: :absolute,
    },
    {
      name: :capacity_at_reference_site_conditions,
      type: :absolute,
    },
    {
      name: :grid_demand,
      type: :absolute,
    },
    {
      name: :equivalent_scheduled_outage_factor,
      type: :absolute,
    },
    {
      name: :equivalent_forced_outage_factor,
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
          fragment: 'sum(capacity_at_actual_site_conditions) as capacity_at_actual_site_conditions_sum,'\
                    'sum(capacity_at_reference_site_conditions) as capacity_at_reference_site_conditions_sum,'\
                    'sum(grid_demand) as grid_demand_sum,'\
                    'sum(equivalent_scheduled_outage_factor) as equivalent_scheduled_outage_factor_sum,'\
                    'sum(equivalent_forced_outage_factor) as equivalent_forced_outage_factor_sum'
        },
        destination: {
          type: :excel,
          template: false,
          filename_prefix: 'kpp_kpi_report',
          worksheet_name: 'plant_declared_readings'
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
          worksheet_name: 'plant_declared_readings'
        }
      }
    ]
  }

  abstract_bootloader()

  validates :capacity_at_actual_site_conditions, {
    presence: true,
    format: {
      with: /\A[0-9]+\.[0-9]{1}\Z/,
      message: 'must contain a decimal place'
    },
    numericality: {
      greater_than_or_equal_to: 0.0,
      less_than: 220.1
    }
  }
  validates :capacity_at_reference_site_conditions, {
    presence: true,
    format: {
      with: /\A[0-9]+\.[0-9]{1}\Z/,
      message: 'must contain a decimal place'
    },
    numericality: {
      greater_than_or_equal_to: 0.0,
      less_than: 220.1
    }
  }
  validates :grid_demand, {
    presence: true,
    format: {
      with: /\A[0-9]+\.[0-9]{1}\Z/,
      message: 'must contain a decimal place'
    },
    numericality: {
      greater_than_or_equal_to: 0.0,
      less_than: 220.1
    }
  }
  validates :equivalent_scheduled_outage_factor, {
    presence: true,
    format: {
      with: /\A[0-9]+\.[0-9]{1}\Z/,
      message: 'must contain a decimal place'
    },
    numericality: {
      greater_than_or_equal_to: 0.0,
      less_than: 196.1
    }
  }
  validates :equivalent_forced_outage_factor, {
    presence: true,
    format: {
      with: /\A[0-9]+\.[0-9]{1}\Z/,
      message: 'must contain a decimal place'
    },
    numericality: {
      greater_than_or_equal_to: 0.0,
      less_than: 196.1
    }
  }
end
