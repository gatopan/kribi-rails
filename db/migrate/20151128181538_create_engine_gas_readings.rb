class CreateEngineGasReadings < Kribi::Migration
  def change
    create_table :engine_gas_hourly_readings do |t|
      t.references :engine, index: true, foreign_key: true
      t.datetime :target_datetime, index: true
      create_relative_counter_value_columns(t, :counter_value)
      t.integer :gas_volume
      t.integer :status, default: 0
      create_match_keys_for(t)

      t.timestamps null: false
    end
    create_table :engine_gas_daily_readings do |t|
      t.references :engine, index: true, foreign_key: true
      t.datetime :target_datetime
      create_relative_counter_value_columns(t, :counter_value)
      t.integer :gas_volume
      t.integer :status, default: 0
      create_match_keys_for(t)

      t.timestamps null: false
    end
  end
end
