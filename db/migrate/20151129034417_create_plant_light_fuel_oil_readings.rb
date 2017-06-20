class CreatePlantLightFuelOilReadings < Kribi::Migration
  def change
    create_table :plant_light_fuel_oil_daily_readings do |t|
      t.references :plant, index: true, foreign_key: true
      t.datetime :target_datetime, index: true
      create_relative_counter_value_columns(t, :inlet_hall_a_counter_value)
      t.float :inlet_hall_a_liters
      create_relative_counter_value_columns(t, :inlet_hall_b_counter_value)
      t.float :inlet_hall_b_liters
      create_relative_counter_value_columns(t, :outlet_counter_value)
      t.float :outlet_cubic_meters
      t.float :consumption_liters
      t.integer :status, default: 0
      create_match_keys_for(t)

      t.timestamps null: false
    end

    create_table :plant_light_fuel_oil_hourly_readings do |t|
      t.references :plant, index: true, foreign_key: true
      t.datetime :target_datetime
      create_relative_counter_value_columns(t, :inlet_hall_a_counter_value)
      t.float :inlet_hall_a_liters
      create_relative_counter_value_columns(t, :inlet_hall_b_counter_value)
      t.float :inlet_hall_b_liters
      create_relative_counter_value_columns(t, :outlet_counter_value)
      t.float :outlet_cubic_meters
      t.float :consumption_liters
      t.integer :status, default: 0
      create_match_keys_for(t)

      t.timestamps null: false
    end
  end
end
