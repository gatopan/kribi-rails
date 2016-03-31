class PlantReferenceConditionReadingsBatchController < AbstractBatchController
  def parent_model
    Plant
  end

  def children_model
    PlantReferenceConditionReading
  end

  def children_attributes
    [
      {
        builder: :text_field,
        attribute: :methane_number_at_actual_site_condition,
        type: :numeric,
        class: 'form-control'
      }
    ]
  end
end
