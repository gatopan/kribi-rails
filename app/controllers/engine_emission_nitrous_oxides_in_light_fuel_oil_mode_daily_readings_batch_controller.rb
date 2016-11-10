class EngineEmissionNitrousOxidesInLightFuelOilModeDailyReadingsBatchController < AbstractBatchController
  def parent_model
    Engine
  end

  def children_model
    EngineEmissionNitrousOxidesInLightFuelOilModeDailyReading
  end

  def children_attributes
    [
      {
        builder: :text_field,
        attribute: :nitrogen_oxides_in_light_fuel_oil_mode,
        class: 'form-control',
        type: :numeric,
        custom_name: 'NOX (mg/m3)'
      },
      {
        builder: :select,
        attribute: :nitrogen_oxides_in_light_fuel_oil_mode_code,
        possible_values: children_model.nitrogen_oxides_in_light_fuel_oil_mode_codes.map{|key, value| [key.humanize, key]},
        class: 'form-control',
        custom_name: :code
      }
    ]
  end
end
