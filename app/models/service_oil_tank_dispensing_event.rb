class ServiceOilTankDispensingEvent < AbstractEventModel
  PARENT_MODEL = ServiceOilTank
  EXPORTER_CONFIG = {
    match_key_types_fragments: [],
    mappings: [
      {
        query: {
          type: :aggregate,
          fragment: 'sum(quantity_in_liters) as quantity_in_liters_sum'
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
  CALCULATED_FIELD_NAMES = [
  ]
  abstract_bootloader()

  belongs_to :engine

  validates :engine, presence: true

  validates :quantity_in_liters, {
    presence: true,
    numericality: {
      greater_than_or_equal_to: 0,
      less_than_or_equal_to: 14000
    }
  }
end
