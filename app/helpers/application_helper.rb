module ApplicationHelper
  def is_active_route(route)
    (route.fetch(:route_name) =~ /#{params[:controller]}/) ? 'active' : nil
  end

  def is_active_controller(controller_name)
    params[:controller] == controller_name ? 'active' : nil
  end

  def is_active_action(action_name)
    params[:action] == action_name ? 'active' : nil
  end

  def is_active_batch
    @batch_routes.any?{|route| route.fetch(:route_name) =~ /#{params[:controller]}/} ? 'active' : nil
  end

  def is_active_event
    @event_routes.any?{|route| route.fetch(:route_name) =~ /#{params[:controller]}/} ? 'active' : nil
  end
end
