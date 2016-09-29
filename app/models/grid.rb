class Grid < ActiveRecord::Base
  has_many :grid_demand_instruction_events
end
