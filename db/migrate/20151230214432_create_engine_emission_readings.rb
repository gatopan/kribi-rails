class CreateEngineEmissionReadings < Kribi::Migration
  def change
    create_table :engine_emission_readings do |t|
      t.references :engine, index: true, foreign_key: true
      t.datetime :target_datetime
      t.float :nitrogen_oxides_in_gas_mode, default: 0.0
      t.integer :nitrogen_oxides_in_gas_mode_code, default: 0
      t.float :nitrogen_oxides_in_light_fuel_oil_mode, default: 0.0
      t.integer :nitrogen_oxides_in_light_fuel_oil_mode_code, default: 0
      t.float :dioxygen, default: 0.0
      t.integer :dioxygen_code, default: 0
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
