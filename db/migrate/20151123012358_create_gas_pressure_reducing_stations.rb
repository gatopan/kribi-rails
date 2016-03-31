class CreateGasPressureReducingStations < Kribi::Migration
  def change
    create_table :gas_pressure_reducing_stations do |t|
      t.timestamps null: false
    end
  end
end
