class CreateChromatographs < Kribi::Migration
  def change
    create_table :chromatographs do |t|
      t.string :name
      t.timestamps null: false
    end
  end
end
