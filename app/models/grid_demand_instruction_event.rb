class GridDemandInstructionEvent < AbstractEventModel
  PARENT_MODEL = Grid
  CUSTOM_NAME = nil
  EXPORTER_CONFIG = {
    match_key_types_fragments: [],
    mappings: [
      # {
      #   query: {
      #     type: :aggregate,
      #     fragment: 'sum(grid_demand) as grid_demand_sum'
      #   },
      #   destination: {
      #     type: :excel,
      #     template: false,
      #     filename_prefix: 'kpp_kpi_report',
      #     worksheet_name: self.table_name
      #   }
      # },
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

  belongs_to :grid

  # TODO: Investigate allowed range
  validates :grid_demand, {
    presence: true,
    numericality: {
      greater_than_or_equal_to: 0,
      less_than_or_equal_to: 1000000
    }
  }
  validates :target_datetime, presence: true # TODO: Verify this is working from abstract model
  validates :comments, presence: true # TODO: Verify this is working from abstract model
end
