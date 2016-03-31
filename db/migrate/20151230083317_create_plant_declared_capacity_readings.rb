class CreatePlantDeclaredCapacityReadings < Kribi::Migration
  def change
    create_table :plant_declared_capacity_readings do |t|
      t.references :plant, index: true, foreign_key: true
      t.datetime :target_datetime
      t.float :capacity_at_actual_site_conditions, default: 0.0
      t.float :capacity_at_reference_site_conditions, default: 0.0
      t.float :grid_demand, default: 0.0
      t.float :equivalent_scheduled_outage_factor, default: 0.0
      t.float :equivalent_forced_outage_factor, default: 0.0
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
      add_index :plant_declared_capacity_readings, "match_key_#{match_key_type}", name: "index_plant_declared_capacity_mk_#{match_key_type}"
    end
  end
end
