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

  get '/all_dumps.zip', to: 'static_pages#all_dumps'

  # TODO: Prettify urls
  AbstractIntervalModel.descendants.each do |model|
    resources "#{model.table_name}_batch" do
      collection do
        get 'batch_show'
        post 'batch_update'
        post 'batch_elevate'
      end
    end
  end

  # TODO: Prettify urls
  AbstractEventModel.descendants.each do |model|
    resources model.table_name do
      collection do
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
