#   root to: 'home#index'
#   get "home/index"
#   get "home/minor"

# Rails.application.routes.draw do
Kribi::Application.routes.draw do
  # Web
  root({
    to: 'static_pages#home',
    as: :home
  })
  post 'register_web', {
    to: 'static_pages#register_web',
    as: :register_web
  }
  post 'login_web', {
    to: 'static_pages#login_web',
    as: :login_web
  }
  get 'logout_web', {
    to: 'static_pages#logout_web',
    as: :logout_web
  }

  # JSON
  post 'register_json', {
    to: 'static_pages#register_json',
    as: :register_json
  }
  post 'login_json', {
    to: 'static_pages#login_json',
    as: :login_json
  }
  get 'logout_json', {
    to: 'static_pages#logout_json',
    as: :logout_json
  }

  [
    :engine_energy_readings_batch,
    :chromatograph_readings_batch,
    :feeder_readings_batch,
    :transformer_readings_batch,
    :substation_readings_batch,
    :gas_pressure_reducing_station_readings_batch,
    :engine_gas_readings_batch,
    :plant_light_fuel_oil_readings_batch,
    :engine_light_fuel_oil_readings_batch,
    :weather_readings_batch,
    :plant_gross_capacity_readings_batch,
    :plant_reference_condition_readings_batch,
    :plant_declared_capacity_readings_batch,
    :gas_nomination_readings_batch,
    :engine_emission_readings_batch,
    :engine_running_time_readings_batch,
    :engine_cooling_water_dispensing_events_batch
  ].each do |resource_name|
    resources resource_name do
      collection do
        get 'batch_show'
        post 'batch_update'
        post 'batch_elevate'
      end
    end
  end

  [
    :engine_cooling_water_dispensing_events,
    :engine_start_events,
    :engine_status_change_events,
    :engine_trip_events,
    :new_oil_tank_dispensing_events,
    :new_oil_tank_receiving_events,
    :service_oil_tank_dispensing_events,
    :service_oil_tank_receiving_events
  ].each do |resource_name|
    resources resource_name do
      collection do
        get 'editor'
        post 'editor'
        # get 'metadata'
        # get 'parents'
        # get 'search'
      end
    end
  end
end
