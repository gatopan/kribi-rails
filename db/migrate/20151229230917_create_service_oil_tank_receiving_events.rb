class CreateServiceOilTankReceivingEvents < Kribi::Migration
  def change
    create_table :service_oil_tank_receiving_events do |t|
      t.references :engine, index: true, foreign_key: true
      t.datetime :target_datetime, index: true
      t.integer :quantity_in_liters
      t.integer :status, default: 0
      create_match_keys_for(t)

      t.timestamps null: false
    end
  end
end
