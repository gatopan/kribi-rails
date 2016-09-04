class WeatherReadingsBatchController < AbstractBatchController
  def parent_model
    WeatherStation
  end

  def children_model
    WeatherReading
  end

  def children_attributes
    [
      {
        builder: :text_field,
        attribute: :ambient_temperature,
        type: :numeric,
        class: 'form-control',
        custom_name: 'Ambient Temperature (°C)'
      },
      {
        builder: :text_field,
        attribute: :absolute_humidity,
        type: :numeric,
        class: 'form-control',
        custom_name: 'Absolute Humidity (g/kg)'
      },
      {
        builder: :text_field,
        attribute: :relative_humidity,
        type: :numeric,
        class: 'form-control',
        custom_name: 'Relative Humidity (%)'
      }
    ]
  end
end
