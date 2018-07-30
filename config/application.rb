require_relative 'boot'
require 'rails/all'
require './lib/kribi' #TODO: Figure out why `Kribi` module was not autoloaded, 

Bundler.require(*Rails.groups)

module Kribi
  class Application < Rails::Application
    config.load_defaults 5.1
    config.autoload_paths << Rails.root.join('lib')
    config.time_zone = 'UTC'
    config.middleware.insert_before 0, Rack::Cors do
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
