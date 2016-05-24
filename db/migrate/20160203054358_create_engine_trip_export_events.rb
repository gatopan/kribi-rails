class CreateEngineTripExportEvents < Kribi::Migration
  def change
    create_table :engine_trip_export_events do |t|
      t.belongs_to :engine, index: true, foreign_key: true
      t.integer :equipment
      t.integer :bank
      t.integer :cylinder
      t.integer :alarm
      t.integer :type
      t.integer :context
      t.integer :owner
      t.integer :light_fuel_oil_consumption_type
      t.float :light_fuel_oil_estimation_in_kilograms
      t.float :power_generated_during_light_fuel_oil_consumption
      t.float :mean_load, default: 0.0
      t.text :observations
      t.datetime :target_datetime
      t.float :duration_in_hours
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
