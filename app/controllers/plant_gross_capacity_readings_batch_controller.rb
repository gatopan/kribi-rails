class PlantGrossCapacityReadingsBatchController < AbstractBatchController
  def parent_model
    Plant
  end

  def children_model
    PlantGrossCapacityReading
  end

  def children_attributes
    [
      {
        builder: :text_field,
        attribute: :output_capacity,
        type: :numeric,
        class: 'form-control'
      }
    ]
  end
end
