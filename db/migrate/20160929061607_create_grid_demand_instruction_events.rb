class CreateGridDemandInstructionEvents < Kribi::Migration
  def change
    create_table :grid_demand_instruction_events do |t|
      t.references :grid, index: true, foreign_key: true
      t.datetime :target_datetime
      t.float :grid_demand, default: 0.0
      t.integer :status, default: 0
      t.text :comments
      create_match_keys_for(t)

      t.timestamps null: false
    end
  end
end
