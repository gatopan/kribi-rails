class CreateEngineRunningTimeReadings < Kribi::Migration
  def change
    create_table :engine_running_time_readings do |t|
      t.references :engine, index: true, foreign_key: true
      t.datetime :target_datetime, index: true
      create_relative_counter_value_columns(t, :counter_value)
      t.integer :elapsed_hours
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
      add_index :engine_running_time_readings, "match_key_#{match_key_type}", name: "index_engine_running_time_readings_mk_#{match_key_type}"
    end
  end
end
