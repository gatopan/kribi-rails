class CreateEngineStatusChangeExportEvents < Kribi::Migration
  def change
    create_table :engine_status_change_export_events do |t|
      t.references :engine, index: true, foreign_key: true
      t.datetime :target_datetime
      t.float :duration_in_hours
      t.integer :type, default: 0
      t.integer :engine_mode, default: 0
      t.integer :derating_mode, default: 0
      t.float :load_limitation, default: 0
      t.text :observation
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
      add_index :engine_status_change_export_events, "match_key_#{match_key_type}", name: "index_engine_stat_chng_evnt_mk_#{match_key_type}"
    end
  end
end
