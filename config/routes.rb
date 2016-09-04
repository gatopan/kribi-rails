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

  get 'export', {
    to: 'static_pages#export',
    as: :export
  }

  get '/all_dumps.zip', to: 'static_pages#all_dumps'

  # JSON
  # post 'register_json', {
  #   to: 'static_pages#register_json',
  #   as: :register_json
  # }
  # post 'login_json', {
  #   to: 'static_pages#login_json',
  #   as: :login_json
  # }
  # get 'logout_json', {
  #   to: 'static_pages#logout_json',
  #   as: :logout_json
  # }

  [
    :engine_energy_daily_readings,
    :engine_energy_hourly_readings,
    :chromatograph_readings,
    :feeder_readings,
    :transformer_readings,
    :substation_readings,
    :gas_pressure_reducing_station_hourly_readings,
    :gas_pressure_reducing_station_daily_readings,
    :engine_gas_hourly_readings,
    :engine_gas_daily_readings,
    :plant_light_fuel_oil_readings,
    :engine_light_fuel_oil_readings,
    :weather_readings,
    :plant_gross_capacity_readings,
    :plant_reference_condition_readings,
    :plant_declared_capacity_readings,
    :gas_nomination_readings,
    :engine_emission_nitrous_oxides_in_light_fuel_oil_mode_hourly_readings,
    :engine_emission_nitrous_oxides_in_light_fuel_oil_mode_daily_readings,
    :engine_emission_nitrous_oxides_in_gas_mode_hourly_readings,
    :engine_emission_nitrous_oxides_in_gas_mode_daily_readings,
    :engine_emission_dioxygen_hourly_readings,
    :engine_emission_dioxygen_daily_readings,
    :engine_running_time_readings
  ].each do |resource_name|
    batch_resource_name = "#{resource_name}_batch"
    resources batch_resource_name do
      collection do
        get 'batch_show'
        post 'batch_update'
        post 'batch_elevate'
      end
    end
  end

  # NOTE: New proposal, must fix model loader
  # AbstractEventModel
  #   .descendants
  #   .map(&:table_name)
  #   .each do |resource_name|
  #     resources resource_name do
  #       collection do
  #         # TODO: Figure out cleaner way of creating editor routes
  #         get 'editor'
  #         post 'editor/create', action: 'editor_create'
  #         post 'editor/update', action: 'editor_update'
  #         post 'editor/destroy', action: 'editor_destroy'
  #         post 'editor/elevate', action: 'editor_elevate'
  #       end
  #     end
  #   end
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
        # TODO: Figure out cleaner way of creating editor routes
        get 'editor'
        post 'editor/create', action: 'editor_create'
        post 'editor/update', action: 'editor_update'
        post 'editor/destroy', action: 'editor_destroy'
        post 'editor/elevate', action: 'editor_elevate'
        post 'editor/collection_elevate', action: 'editor_collection_elevate'
      end
    end
  end
end
