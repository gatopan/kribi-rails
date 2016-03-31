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
        builder: :text_field,
        attribute: :grid_demand,
        type: :numeric,
        class: 'form-control'
      },
      {
        builder: :text_field,
        attribute: :equivalent_scheduled_outage_factor,
        type: :numeric,
        class: 'form-control'
      },
      {
        builder: :text_field,
        attribute: :equivalent_forced_outage_factor,
        type: :numeric,
        class: 'form-control'
      }
    ]
  end
end
