class CreateEngineLightFuelOilReadings < Kribi::Migration
  def change
    create_table :engine_light_fuel_oil_readings do |t|
      t.references :engine, index: true, foreign_key: true
      t.datetime :target_datetime, index: true
      create_relative_counter_value_columns(t, :inlet_counter_value)
      t.float :inlet_volume
      create_relative_counter_value_columns(t, :outlet_counter_value)
      t.float :outlet_volume
      t.float :consumption
      t.integer :status, default: 0
      [
        :standard_daily,
        :standard_weekly,
        :standard_monthly,
        :standard_quarter,
        :standard_yearly,
        :customer_monthly
      ].each do |match_key_type|
        t.send(:string, "match_key_#{match_key_type}", index: false)
      end

      t.timestamps null: false
    end
    [
      :standard_daily,
      :standard_weekly,
      :standard_monthly,
      :standard_quarter,
      :standard_yearly,
      :customer_monthly
    ].each do |match_key_type|
      add_index :engine_light_fuel_oil_readings, "match_key_#{match_key_type}", name: "index_engine_lfo_reading_match_key_#{match_key_type}"
    end
  end
end
