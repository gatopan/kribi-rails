class CreateEngineEmissionReadings < Kribi::Migration
  def change
    create_table :engine_emission_nitrous_oxides_in_gas_mode_hourly_readings do |t|
      t.references :engine, index: { name: "index_#{Digest::SHA1.hexdigest(t.name)}_in_engine_id"}, foreign_key: true
      t.datetime :target_datetime, index: { name: SecureRandom.uuid }
      t.float :nitrogen_oxides_in_gas_mode, default: 0.0
      t.integer :nitrogen_oxides_in_gas_mode_code, default: 0
      t.integer :status, default: 0
      create_match_keys_for(t)

      t.timestamps null: false
    end
    create_table :engine_emission_nitrous_oxides_in_light_fuel_oil_mode_hourly_readings do |t|
      t.references :engine, index: { name: "index_#{Digest::SHA1.hexdigest(t.name)}_in_engine_id"}, foreign_key: true
      t.datetime :target_datetime, index: { name: SecureRandom.uuid }
      t.float :nitrogen_oxides_in_light_fuel_oil_mode, default: 0.0
      t.integer :nitrogen_oxides_in_light_fuel_oil_mode_code, default: 0
      t.integer :status, default: 0
      create_match_keys_for(t)

      t.timestamps null: false
    end
    create_table :engine_emission_dioxygen_hourly_readings do |t|
      t.references :engine, index: { name: "index_#{Digest::SHA1.hexdigest(t.name)}_in_engine_id"}, foreign_key: true
      t.datetime :target_datetime, index: { name: SecureRandom.uuid }
      t.float :dioxygen, default: 0.0
      t.integer :dioxygen_code, default: 0
      t.integer :status, default: 0
      create_match_keys_for(t)

      t.timestamps null: false
    end
    create_table :engine_emission_nitrous_oxides_in_gas_mode_daily_readings do |t|
      t.references :engine, index: { name: "index_#{Digest::SHA1.hexdigest(t.name)}_in_engine_id"}, foreign_key: true
      t.datetime :target_datetime, index: { name: SecureRandom.uuid }
      t.float :nitrogen_oxides_in_gas_mode, default: 0.0
      t.integer :nitrogen_oxides_in_gas_mode_code, default: 0
      t.integer :status, default: 0
      create_match_keys_for(t)

      t.timestamps null: false
    end
    create_table :engine_emission_nitrous_oxides_in_light_fuel_oil_mode_daily_readings do |t|
      t.references :engine, index: { name: "index_#{Digest::SHA1.hexdigest(t.name)}_in_engine_id"}, foreign_key: true
      t.datetime :target_datetime, index: { name: SecureRandom.uuid }
      t.float :nitrogen_oxides_in_light_fuel_oil_mode, default: 0.0
      t.integer :nitrogen_oxides_in_light_fuel_oil_mode_code, default: 0
      t.integer :status, default: 0
      create_match_keys_for(t)

      t.timestamps null: false
    end
    create_table :engine_emission_dioxygen_daily_readings do |t|
      t.references :engine, index: { name: "index_#{Digest::SHA1.hexdigest(t.name)}_in_engine_id"}, foreign_key: true
      t.datetime :target_datetime, index: { name: SecureRandom.uuid }
      t.float :dioxygen, default: 0.0
      t.integer :dioxygen_code, default: 0
      t.integer :status, default: 0
      create_match_keys_for(t)

      t.timestamps null: false
    end
  end
end
