class EngineEmissionNitrousOxidesInGasModeHourlyReadingsBatchController < AbstractBatchController
  def parent_model
    Engine
  end

  def children_model
    EngineEmissionNitrousOxidesInGasModeHourlyReading
  end

  def children_attributes
    [
      {
        builder: :text_field,
        attribute: :nitrogen_oxides_in_gas_mode,
        class: 'form-control',
        type: :numeric,
        custom_name: 'NOX - Nitrogen oxides (mg/m3)'
      },
      {
        builder: :select,
        attribute: :nitrogen_oxides_in_gas_mode_code,
        possible_values: children_model.nitrogen_oxides_in_gas_mode_codes.map{|key, value| [key.humanize, key]},
        class: 'form-control',
        custom_name: :code
      }
    ]
  end
end
