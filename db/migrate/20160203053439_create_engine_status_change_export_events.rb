class CreateEngineStatusChangeExportEvents < Kribi::Migration
  def change
    create_table :engine_status_change_export_events do |t|
      t.references :engine, index: true, foreign_key: true
      t.datetime :target_datetime, index: true
      t.float :duration_in_hours
      t.integer :engine_mode, default: 0
      t.integer :derating_mode, default: 0
      t.float :load_limitation, default: 0
      t.text :observation
      t.integer :status, default: 0
      create_match_keys_for(t)

      t.timestamps null: false
    end
  end
end
