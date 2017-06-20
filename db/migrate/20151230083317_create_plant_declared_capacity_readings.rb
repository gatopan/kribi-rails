class CreatePlantDeclaredCapacityReadings < Kribi::Migration
  def change
    create_table :plant_declared_capacity_readings do |t|
      t.references :plant, index: true, foreign_key: true
      t.datetime :target_datetime, index: true
      t.float :capacity_at_actual_site_conditions, default: 0.0
      t.float :capacity_at_reference_site_conditions, default: 0.0
      t.integer :status, default: 0
      t.integer :grid_disturbances, default: 0
      create_match_keys_for(t)

      t.timestamps null: false
    end
  end
end
