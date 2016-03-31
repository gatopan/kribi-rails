# TODO:Rename to AbstractController and update refs
class ApplicationController < ActionController::Base
  helper_method :current_person
  before_action :authenticate
  before_action :prevent_guest_acesss
  before_action :calculate_routes

  def calculate_routes
    routes = Rails.application.routes.named_routes.routes
    @batch_routes ||= routes
      .select{|route_name, route_object| route_name =~ /batch_show/}
      .map{|route_name, route_object|
        resource_name_array = route_name.to_s.split("_")
        resource_name = resource_name_array[2..(resource_name_array.length - 4)].join(' ').humanize
        {
          resource_name: resource_name,
          resource_path: self.send("#{route_name}_path"),
          route_name: route_name,
          route_object: route_object
        }
      }
    @batch_routes.sort_by!{|route| route.fetch(:resource_name)}
    @event_routes ||= routes
      .select{|route_name, route_object| (route_name =~ /editor_/) && (route_name =~/_events/)}
      .map{|route_name, route_object|
        resource_name_array = route_name.to_s.split("_")
        resource_name = resource_name_array[1..(resource_name_array.length - 2)].join(' ').humanize
        {
          resource_name: resource_name,
          resource_path: self.send("#{route_name}_path"),
          route_name: route_name,
          route_object: route_object
        }
      }
    @event_routes.sort_by!{|route| route.fetch(:resource_name)}
  end

  protect_from_forgery with: :exception

  rescue_from StandardError do |exception|
    case Rails.env
    when 'development'
      message = {
        message: exception.message,
        application_backtrace: exception.backtrace.select{|line| line =~ /kribi/},
        # full_backtrace: exception.backtrace
      }
    when 'production'
      case exception
      when ActiveRecord::RecordNotFound
        message = 'Record not found.'
      else
        message = 'Internal server error. Please contact support.'
      end
    end

    render_bad_request(message)
  end

  def prevent_guest_acesss
    if current_person.GUEST?
      render_bad_request('This url is restricted')
    end
  end

  def authenticate
    json_token = /Token token="(\w{32}+)"/.match(request.env["HTTP_AUTHORIZATION"]).try(:[], 1)
    web_token ||= session[:token]

    if json_token
      unless person = Person.find_by(token: json_token)
        render_unauthorized('Bad token or session expired')
      end
    end

    if web_token
      unless person = Person.find_by(token: web_token)
        flash[:warning] = 'Bad token or session expired'
        flash.keep
        session.clear
        redirect_to home_path
      end
    end

    person ||= Person.new(role: :GUEST)

    self.current_person = person
  end

  def current_person=(person)
    RequestStore.store[:current_person] ||= person
  end

  def current_person
    RequestStore.store[:current_person]
  end

  def render_server_ok(message)
    render json: { message: message }, status: 200
  end

  def render_bad_request(message)
    if message.is_a?(Hash)
      render json: message, status: 400
    else
      render json: { message: message }, status: 400
    end
  end

  def render_unauthorized(message)
    render json: { message: message }, status: 403
  end

  def render_server_error(message)
    render json: { message: message }, status: 500
  end
end
