class CreateNewOilTankDispensingEvents < Kribi::Migration
  def change
    create_table :new_oil_tank_dispensing_events do |t|
      t.references :new_oil_tank, index: true, foreign_key: true
      t.references :engine, index: true, foreign_key: true
      t.datetime :target_datetime
      # create_relative_counter_value_columns(t, :counter_value)
      t.integer :quantity_in_liters
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
      add_index :new_oil_tank_dispensing_events, "match_key_#{match_key_type}", name: "index_new_oil_tank_disp_event_mk_#{match_key_type}"
    end
  end
end
