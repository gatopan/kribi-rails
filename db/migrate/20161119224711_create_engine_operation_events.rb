class CreateEngineOperationEvents < Kribi::Migration
  def change
    create_table :engine_operation_events do |t|
      t.belongs_to :engine, index: true, foreign_key: true
      t.datetime :target_datetime
      t.integer :type
      t.integer :subtype
      t.integer :bank
      t.integer :cylinder
      t.integer :equipment
      t.integer :context
      t.integer :ocurrence
      t.integer :owner
      t.datetime :end_time_of_trip
      t.datetime :end_time_without_generation
      t.float :mean_load, default: 0.0
      
      # calculated
      t.float :duration_in_hours
      t.float :energy_in_mwh
      t.float :light_fuel_oil_without_generation_in_kg
      t.float :light_fuel_oil_with_generation_in_kg
      t.integer :failed_start_due_to_pilot_trip_ocurrence
      
      t.text :observations
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
