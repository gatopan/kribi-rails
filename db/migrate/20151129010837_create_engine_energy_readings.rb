class CreateEngineEnergyReadings < Kribi::Migration
  def change
    create_table :engine_energy_readings do |t|
      t.references :engine, index: true, foreign_key: true
      t.datetime :target_datetime
      create_relative_counter_value_columns(t, :counter_value)
      t.float :energy_volume, default: 0, index: true
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
