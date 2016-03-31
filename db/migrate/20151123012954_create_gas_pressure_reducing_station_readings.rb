class CreateGasPressureReducingStationReadings < Kribi::Migration
  def change
    create_table :gas_pressure_reducing_station_readings do |t|
      t.references :gas_pressure_reducing_station, index: false, foreign_key: true
      t.datetime :target_datetime
      create_relative_counter_value_columns(t, :counter_value)
      t.integer :gas_volume
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
      add_index :gas_pressure_reducing_station_readings, "match_key_#{match_key_type}", name: "index_gprs_match_key_#{match_key_type}"
    end

    add_index :gas_pressure_reducing_station_readings, :gas_pressure_reducing_station_id, name:"index_gprs_readings"
  end
end
