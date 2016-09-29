class PlantLightFuelOilDailyReadingsBatchController < AbstractBatchController
  def parent_model
    Plant
  end

  def children_model
    PlantLightFuelOilDailyReading
  end

  def children_attributes
    [
      {
        builder: :text_field,
        attribute: :inlet_hall_a_counter_value,
        type: :numeric,
        class: 'form-control',
        custom_name: 'Common LFO Inlet Hall A (Liters)'
      },
      {
        builder: :text_field,
        attribute: :inlet_hall_a_counter_offset,
        class: 'form-control reset-toggleable',
        type: :numeric
      },
      {
        builder: :text_field,
        attribute: :inlet_hall_a_real_value,
        class: 'form-control reset-toggleable',
        type: :numeric,
        editable: false
      },
      {
        builder: :text_field,
        attribute: :inlet_hall_b_counter_value,
        type: :numeric,
        class: 'form-control',
        custom_name: 'Common LFO Inlet Hall B (Liters)'
      },
      {
        builder: :text_field,
        attribute: :inlet_hall_b_counter_offset,
        class: 'form-control reset-toggleable',
        type: :numeric
      },
      {
        builder: :text_field,
        attribute: :inlet_hall_b_real_value,
        class: 'form-control reset-toggleable',
        type: :numeric,
        editable: false
      },
      {
        builder: :text_field,
        attribute: :outlet_counter_value,
        type: :numeric,
        class: 'form-control',
        custom_name: 'Common Outlet (kg)'
      },
      {
        builder: :text_field,
        attribute: :outlet_counter_offset,
        class: 'form-control reset-toggleable',
        type: :numeric
      },
      {
        builder: :text_field,
        attribute: :outlet_real_value,
        class: 'form-control reset-toggleable',
        type: :numeric,
        editable: false
      }
    ]
  end
end
