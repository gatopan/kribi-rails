class CreatePlantGrossCapacityReadings < Kribi::Migration
  def change
    create_table :plant_gross_capacity_readings do |t|
      t.references :plant, index: true, foreign_key: true
      t.datetime :target_datetime, index: true
      t.float :output_capacity, default: 0.0
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
      add_index :plant_gross_capacity_readings, "match_key_#{match_key_type}", name: "index_plant_gross_capacity_mk_#{match_key_type}"
    end
  end
end
