class CreateGasNominationReadings < Kribi::Migration
  def change
    create_table :gas_nomination_readings do |t|
      t.references :gas_pressure_reducing_station, index: false, foreign_key: true
      t.datetime :target_datetime
      t.float :nomination, default: 0.0
      t.float :delivery, default: 0.0
      t.string :quality, default: 0.0
      t.float :high_heating_value, default: 0.0
      t.float :contractual_methane_number, default: 60.0
      t.integer :status, default: 0
      create_match_keys_for(t)

      t.timestamps null: false
    end
    add_index :gas_nomination_readings, :gas_pressure_reducing_station_id, name:"index_gprs_gas_nomination_readings"
  end
end
