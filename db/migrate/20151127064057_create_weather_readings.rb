class CreateWeatherReadings < Kribi::Migration
  def change
    create_table :weather_readings do |t|
      t.references :weather_station, index: true, foreign_key: true
      t.datetime :target_datetime, index: true
      t.float :ambient_temperature, default: 0.0
      t.float :absolute_humidity, default: 0.0
      t.float :relative_humidity, default: 0.0
      t.integer :status, default: 0
      [
        :standard_daily,
        :standard_weekly,
        :standard_monthly,
        :standard_quarter,
        :standard_yearly,
        :customer_monthly
      ].each do |match_key_type|
        t.send(:string, "match_key_#{match_key_type}", index: true)
      end

      t.timestamps null: false
    end
  end
end
