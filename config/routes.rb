load './config/initializers/model_loader.rb'

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

  get 'readme', {
    to: 'static_pages#readme',
    as: :readme
  }

  post :generate_dumps, to: 'static_pages#generate_dumps'
  get '/all_dumps.zip', to: 'static_pages#all_dumps'

  # TODO: Prettify urls
  AbstractModel.descendants.each do |model|
    case model.table_name
    when /export/
      next
    when /events/
      type = :events
      target = model.table_name.sub('_events', '')
      target = target.gsub('_', '-')

      # /events/engine_trip
      scope "/#{type}" do
        get  target, to: "#{model.table_name}#editor", as: "#{model.table_name}_show"
        post "#{target}/create", to: "#{model.table_name}#editor_create", as: "#{model.table_name}_create"
        post "#{target}/update", to: "#{model.table_name}#editor_update", as: "#{model.table_name}_update"
        post "#{target}/destroy", to: "#{model.table_name}#editor_destroy", as: "#{model.table_name}_destroy"
        post "#{target}/elevate", to: "#{model.table_name}#editor_elevate", as: "#{model.table_name}_elevate"
        post "#{target}/collection_elevate", to: "#{model.table_name}#editor_collection_elevate", as: "#{model.table_name}_collection_elevate"
      end
    when /readings/
      type = :readings

      target = model.table_name.sub('_readings', '')

      case target
      when /daily/
        frequency = :daily
        target = target.sub('_daily', '')
      when /hourly/
        frequency = :hourly
        target = target.sub('_hourly', '')
      else
        frequency = :other
        target = target
      end

      target = target.gsub('_', '-')

      path = (frequency == :other) ? target : "#{target}/#{frequency}"

      scope "/#{type}" do
        get  path, to: "#{model.table_name}_batch#batch_show", as: "#{model.table_name}_show"
        post path, to: "#{model.table_name}_batch#batch_update", as: "#{model.table_name}_update"
        post "#{path}/elevate", to: "#{model.table_name}_batch#batch_elevate", as: "#{model.table_name}_elevate"
      end
    else
      next
    end
  end

  # AbstractIntervalModel.descendants.each do |model|
  #   resources "#{model.table_name}_batch" do
  #     collection do
  #       get 'batch_show'
  #       post 'batch_update'
  #       post 'batch_elevate'
  #     end
  #   end
  # end
  # AbstractEventModel.descendants.each do |model|
  #   resources model.table_name do
  #     collection do
  #       get 'editor'
  #       post 'editor/create', action: 'editor_create'
  #       post 'editor/update', action: 'editor_update'
  #       post 'editor/destroy', action: 'editor_destroy'
  #       post 'editor/elevate', action: 'editor_elevate'
  #       post 'editor/collection_elevate', action: 'editor_collection_elevate'
  #     end
  #   end
  # end
end
