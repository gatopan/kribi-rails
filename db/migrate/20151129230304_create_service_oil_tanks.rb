class CreateServiceOilTanks < Kribi::Migration
  def change
    create_table :service_oil_tanks do |t|
      t.string :name
      t.integer :content

      t.timestamps null: false
    end
  end
end
