class EngineEmissionDioxygenHourlyReadingsBatchController < AbstractBatchController
  def parent_model
    Engine
  end

  def children_model
    EngineEmissionDioxygenHourlyReading
  end

  def children_attributes
    [
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
