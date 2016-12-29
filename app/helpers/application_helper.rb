module ApplicationHelper
  def is_active_route(route)
    return true
    ((route.fetch(:route_name)+'_batch') =~ /#{params[:controller]}/) ? 'active' : nil
  end

  def is_active_controller(controller_name)
    params[:controller] == controller_name ? 'active' : nil
  end

  def is_active_action(action_name)
    params[:action] == action_name ? 'active' : nil
  end

  def is_active_batch
    return ''
    batch_routes.any?{|route| (route.fetch(:route_name)+'_batch')  =~ /#{params[:controller]}/} ? 'active' : nil
  end

  def is_active_event
    return ''
    event_routes.any?{|route| route.fetch(:route_name) =~ /#{params[:controller]}/} ? 'active' : nil
  end

  def body_class
    @body_class ||= "#{params.fetch(:controller).gsub("_", "-")}-#{params.fetch(:action).gsub("_", "-")}"
  end
end
