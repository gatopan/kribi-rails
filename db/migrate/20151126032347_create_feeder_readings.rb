class CreateFeederReadings < Kribi::Migration
  def change
    create_table :feeder_readings do |t|
      t.references :feeder, index: true, foreign_key: true
      t.datetime :target_datetime, index: true
      create_relative_counter_value_columns(t, :transmitting_counter_value)
      create_relative_counter_value_columns(t, :receiving_counter_value)
      t.float :transmitting_energy_volume
      t.float :receiving_energy_volume
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
