class EngineEmissionReadingsBatchController < AbstractBatchController
  def parent_model
    Engine
  end

  def children_model
    EngineEmissionReading
  end

  def children_attributes
    [
      {
        builder: :text_field,
        attribute: :nitrogen_oxides_in_gas_mode,
        class: 'form-control',
        type: :numeric,
        custom_name: :nox_in_gas_mode
      },
      {
        builder: :select,
        attribute: :nitrogen_oxides_in_gas_mode_code,
        possible_values: children_model.nitrogen_oxides_in_gas_mode_codes.map{|key, value| [key.humanize, key]},
        class: 'form-control',
        custom_name: :code
      },
      {
        builder: :text_field,
        attribute: :nitrogen_oxides_in_light_fuel_oil_mode,
        class: 'form-control',
        type: :numeric,
        custom_name: :nox_in_lfo_mode
      },
      {
        builder: :select,
        attribute: :nitrogen_oxides_in_light_fuel_oil_mode_code,
        possible_values: children_model.nitrogen_oxides_in_light_fuel_oil_mode_codes.map{|key, value| [key.humanize, key]},
        class: 'form-control',
        custom_name: :code
      },
      {
        builder: :text_field,
        attribute: :dioxygen,
        class: 'form-control',
        type: :numeric
      },
      {
        builder: :select,
        attribute: :dioxygen_code,
        possible_values: children_model.dioxygen_codes.map{|key, value| [key.humanize, key]},
        class: 'form-control',
        custom_name: :code
      }
    ]
  end
end
