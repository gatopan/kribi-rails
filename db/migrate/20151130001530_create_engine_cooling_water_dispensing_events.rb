class CreateEngineCoolingWaterDispensingEvents < Kribi::Migration
  def change
    create_table :engine_cooling_water_dispensing_events do |t|
      t.references :engine, index: true, foreign_key: true
      t.datetime :target_datetime
      t.integer :quantity_in_liters, default: 0.0
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
      add_index :engine_cooling_water_dispensing_events, "match_key_#{match_key_type}", name: "index_engine_water_disp_event_mk_#{match_key_type}"
    end
  end
end
