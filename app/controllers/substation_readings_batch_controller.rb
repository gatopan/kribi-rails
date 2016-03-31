class SubstationReadingsBatchController < AbstractBatchController
  def parent_model
    Substation
  end

  def children_model
    SubstationReading
  end

  def children_attributes
    [
      {
        builder: :text_field,
        attribute: :counter_value,
        type: :numeric,
        class: 'form-control'
      },
      {
        builder: :text_field,
        attribute: :counter_offset,
        class: 'form-control reset-toggleable',
        type: :numeric
      },
      {
        builder: :text_field,
        attribute: :real_value,
        class: 'form-control reset-toggleable',
        type: :numeric,
        editable: false
      }
    ]
  end
end
