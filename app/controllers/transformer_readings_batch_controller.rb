class TransformerReadingsBatchController < AbstractBatchController
  def parent_model
    Transformer
  end

  def children_model
    TransformerReading
  end

  def children_attributes
    [
      {
        builder: :text_field,
        attribute: :transmitting_counter_value,
        type: :numeric,
        class: 'form-control',
        custom_name: 'Transmitted (MWh)'
      },
      {
        builder: :text_field,
        attribute: :transmitting_counter_offset,
        class: 'form-control reset-toggleable',
        type: :numeric,
      },
      {
        builder: :text_field,
        attribute: :transmitting_real_value,
        class: 'form-control reset-toggleable',
        type: :numeric,
        editable: false,
      },
      {
        builder: :text_field,
        attribute: :receiving_counter_value,
        type: :numeric,
        class: 'form-control',
        custom_name: 'Received (MWh)'
      },
      {
        builder: :text_field,
        attribute: :receiving_counter_offset,
        class: 'form-control reset-toggleable',
        type: :numeric,
      },
      {
        builder: :text_field,
        attribute: :receiving_real_value,
        class: 'form-control reset-toggleable',
        type: :numeric,
        editable: false,
      }
    ]
  end
end
