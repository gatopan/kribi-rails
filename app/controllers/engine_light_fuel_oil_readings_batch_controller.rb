class EngineLightFuelOilReadingsBatchController < AbstractBatchController
  def parent_model
    Engine
  end

  def children_model
    EngineLightFuelOilReading
  end

  def children_attributes
    [
      {
        builder: :text_field,
        attribute: :inlet_counter_value,
        type: :numeric,
        class: 'form-control',
      },
      {
        builder: :text_field,
        attribute: :inlet_counter_offset,
        class: 'form-control reset-toggleable',
        type: :numeric,
      },
      {
        builder: :text_field,
        attribute: :inlet_real_value,
        class: 'form-control reset-toggleable',
        type: :numeric,
        editable: false,
      },
      {
        builder: :text_field,
        attribute: :outlet_counter_value,
        type: :numeric,
        class: 'form-control',
      },
      {
        builder: :text_field,
        attribute: :outlet_counter_offset,
        class: 'form-control reset-toggleable',
        type: :numeric,
      },
      {
        builder: :text_field,
        attribute: :outlet_real_value,
        class: 'form-control reset-toggleable',
        type: :numeric,
        editable: false,
      }
    ]
  end
end
