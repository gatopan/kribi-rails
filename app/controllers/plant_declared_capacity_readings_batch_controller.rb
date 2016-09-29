class PlantDeclaredCapacityReadingsBatchController < AbstractBatchController
  def parent_model
    Plant
  end

  def children_model
    PlantDeclaredCapacityReading
  end

  def children_attributes
    [
      {
        builder: :text_field,
        attribute: :capacity_at_actual_site_conditions,
        type: :numeric,
        class: 'form-control'
      },
      {
        builder: :text_field,
        attribute: :capacity_at_reference_site_conditions,
        type: :numeric,
        class: 'form-control'
      },
      {
        builder: :select,
        attribute: :grid_disturbances,
        possible_values: children_model.grid_disturbances.map{|key, value| [key.humanize, key]},
        class: 'form-control'
      }
    ]
  end
end
