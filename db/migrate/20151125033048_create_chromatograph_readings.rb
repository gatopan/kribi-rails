class CreateChromatographReadings < Kribi::Migration
  def change
    create_table :chromatograph_readings do |t|
      t.references :chromatograph, index: true, foreign_key: true
      t.datetime :target_datetime
      t.float :un_norm_total, default: 0.001
      t.float :higher_heating_value, default: 0.001
      t.float :lower_heating_value, default: 0.001
      t.float :specific_gravity, default: 0.001
      t.float :compressibility, default: 0.001
      t.float :propane, default: 0.001
      t.float :isobutane, default: 0.001
      t.float :normal_butane, default: 0.0
      t.float :neopentane, default: 0.001
      t.float :isopentane, default: 0.0
      t.float :normal_pentane, default: 0.0
      t.float :hexane_and_more, default: 0.0
      t.float :nitrogen, default: 0.001
      t.float :methane, default: 0.001
      t.float :carbon_dioxide, default: 0.001
      t.float :ethane, default: 0.001
      t.float :grouped_pentane
      t.float :grouped_butane
      t.float :corrected_methane
      t.float :corrected_butane
      t.float :methane_number, default: 0.0
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
