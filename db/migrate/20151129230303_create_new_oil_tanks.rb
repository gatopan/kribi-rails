class CreateNewOilTanks < Kribi::Migration
  def change
    create_table :new_oil_tanks do |t|
      t.string :name
      t.integer :content

      t.timestamps null: false
    end
  end
end
