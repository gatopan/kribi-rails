class CreateEngineStartEvents < Kribi::Migration
  def change
    create_table :engine_start_events do |t|
      t.references :engine, index: true, foreign_key: true
      t.datetime :target_datetime
      t.integer :bank
      t.integer :result
      t.integer :equipment
      t.integer :cylinder
      t.integer :alarm
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
