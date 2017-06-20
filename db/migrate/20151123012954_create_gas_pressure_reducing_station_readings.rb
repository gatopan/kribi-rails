class CreateGasPressureReducingStationReadings < Kribi::Migration
  def change
    create_table :gas_pressure_reducing_station_daily_readings do |t|
      t.references :gas_pressure_reducing_station, index: false, foreign_key: true
      t.datetime :target_datetime, index: { name: SecureRandom.uuid }
      create_relative_counter_value_columns(t, :counter_value)
      t.integer :gas_volume
      t.integer :status, default: 0
      create_match_keys_for(t)

      t.timestamps null: false
    end

    add_index :gas_pressure_reducing_station_daily_readings, :gas_pressure_reducing_station_id, name:"index_daily_gprs_readings"

    create_table :gas_pressure_reducing_station_hourly_readings do |t|
      t.references :gas_pressure_reducing_station, index: false, foreign_key: true
      t.datetime :target_datetime
      create_relative_counter_value_columns(t, :counter_value)
      t.integer :gas_volume
      t.integer :status, default: 0
      create_match_keys_for(t)

      t.timestamps null: false
    end

    add_index :gas_pressure_reducing_station_hourly_readings, :gas_pressure_reducing_station_id, name:"index_hourly_gprs_readings"
  end
end
