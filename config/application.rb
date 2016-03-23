require File.expand_path('../boot', __FILE__)
require 'rails/all'
require './lib/kribi' #TODO: Figure out why `Kribi` module was not autoloaded, 

Bundler.require(*Rails.groups)

module Kribi
  class Application < Rails::Application
    config.autoload_paths << Rails.root.join('lib')
    config.active_record.raise_in_transactional_callbacks = true
    config.time_zone = 'UTC'
    config.middleware.use Rack::Cors do
      allow do
        origins '*'
        resource '*',
          :headers => :any,
          :methods => [:get, :post, :options, :put, :patch, :delete]# ,
          # :expose  => ['begin', 'end', 'total_items']
      end
    end
  end
end
