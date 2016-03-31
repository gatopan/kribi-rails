class CreateWeatherStations < Kribi::Migration
  def change
    create_table :weather_stations do |t|

      t.timestamps null: false
    end
  end
end
