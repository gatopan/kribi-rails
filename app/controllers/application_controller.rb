# TODO:Rename to AbstractController and update refs
class ApplicationController < ActionController::Base
  helper_method :current_person
  helper_method :batch_routes
  helper_method :event_routes
  before_action :authenticate
  before_action :prevent_guest_acesss

  def initialize
    load './config/initializers/model_loader.rb'
    super
  end

  # TODO: fix incongruence batch vs interval incongruence
  def batch_routes
    @batch_routes ||= AbstractIntervalModel.descendants
      .map do |model|
        {
          resource_name: model.custom_name,
          resource_path: self.send("batch_show_#{model.table_name}_batch_index_path"),
          route_name: model.table_name,
          model: model
        }
    end.sort_by do |batch_route|
      batch_route[:resource_name]
    end
  end

  def event_routes
    @event_routes ||= AbstractEventModel.descendants.reject do |model|
      model.to_s =~ /Export/
    end.map do |model|
      {
        resource_name: model.custom_name,
        resource_path: self.send("#{model.table_name}_path") + '/editor',
        route_name: model.table_name,
        model: model
      }
    end.sort_by do |event_route|
      event_route[:resource_name]
    end
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
