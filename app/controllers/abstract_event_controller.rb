# NOTE: Currently has CRUD methods commented, only editor methods enabled,
# perhaps split into two controllers?
class AbstractEventController < ApplicationController
  before_action :cast_datetimes
  helper_method(
    :children_model
  )

  # TODO: convert to use filters scope
  # TODO figure out how to not need the flash clear
  def editor
    @body_class = 'event-editor'

    @unpaginated_children = children_model.where(parent_model_column => current_parent_id)
    @metadata = calculated_metadata
    @parents = calculated_parents
    @children = paginated_children_model.where(parent_model_column => current_parent_id)
    @current_parent = current_parent
    @new_child = session.delete(:pending_member) || children_model.new

    unless @current_parent
      flash[:warning] = "Please select a #{parent_model.to_s.titleize}."
    end

    render './event_editor.html.erb'
  end

  def editor_create
    @member = children_model.new(final_params)

    if @member.save
      flash[:success] = 'Sucessfully created a new record.'
    else
      flash[:warning] = "Could not create record: #{@member.errors.messages}."
      session[:pending_member] = @member
    end

    flash.keep
    redirect_to request.referrer
  end

  def editor_update
    @member = children_model.find(params[:id])

    if (@member.status == 'APPROVED') && (current_person.allowed_statuses.exclude? 'APPROVED')
      return render_bad_request('Record is already approved. Request a change from your Approver')
    end

    if @member.update(final_params)
      flash[:success] = 'Sucessfully updated record.'
    else
      flash[:warning] = "Could not update record: #{@member.errors.messages}."
    end

    flash.keep
    redirect_to request.referrer
  end

  def editor_destroy
    @member = children_model.find(params[:id])

    if (@member.status == 'APPROVED') && (current_person.allowed_statuses.exclude? 'APPROVED')
      return render_bad_request('Record is already approved. Request a change from your Approver')
    end

    if @member.destroy
      flash[:success] = 'Sucessfully deleted record.'
    else
      flash[:warning] = "Could not delete record: #{@member.errors.messages}."
    end

    flash.keep
    redirect_to request.referrer
  end

  def editor_collection_elevate
    ids = params[:ids].split(',').map{|id| id.to_i}
    @members = children_model.where(id: ids)
    intended_status = params[:intended_status]

    ActiveRecord::Base.transaction do
      @members.each do |member|
        member.update!(status: intended_status)
      end
    end

    service = Kribi::Exporter::Performer.new(:all)
    service.perform

    flash[:success] = 'Sucessfully updated selected records.'
    flash.keep
    redirect_to request.referrer
  end

  def editor_elevate
    @member = children_model.find(params[:id])

    unless intended_status = params[:intended_status]
      return render_bad_request('Must submit a intended_status')
    end

    unless current_person.allowed_statuses.include? intended_status
      return render_bad_request('Submitted status is forbidden for current person or record has already been approved')
    end

    if (@member.status == 'APPROVED') && (current_person.allowed_statuses.exclude? 'APPROVED')
      return render_bad_request('Record is already approved. Request a change from your Approver')
    end

    # TODO: Add approver locks

    if @member.valid? && @member.valid?(:congruence)
      if @member.update(status: intended_status)
        service = Kribi::Exporter::Performer.new(:all)
        service.perform
        flash[:success] = "Sucessfully updated status to #{intended_status.downcase} on selected record."
      else
        flash[:warning] = 'Error while updating status on selected resource.'
      end
    else
      flash[:warning] = "Selected record has not passed all validations: #{@member.errors.messages}."
    end

    flash.keep
    redirect_to request.referrer
  end

  private

  # TODO: move this to abstract model
  # NOTE: Converted parent model column to implicit
  # TODO: Implement enum explicit UI names
  def calculated_attribute_metadata
    whitelisted_columns
      .select do |column|
        column.name != parent_model_column
      end.map do |column|
        type = column.type

        case column.name
        when /_id/
          column_name = column.name.sub('_id', '')

          reflection =
            children_model
            .reflect_on_association(column_name)

          type = :belongs_to

          possible_values = reflection.klass.ids
        else
          enum = children_model.defined_enums[column.name]
          type = enum ? :enum : type
          possible_values = enum ? enum.keys : []
        end

        {
          name: column.name,
          type: type,
          possible_values: possible_values,
          editable: ['id', *children_model::CALCULATED_FIELD_NAMES].exclude?(column.name)
        }
      end
  end

  # TODO: move this to abstract model
  def calculated_metadata
    {
      total_records_count: children_model.count,
      pagination_records_counters: children_model.group(parent_model_column).count,
      pagination_upper_limit: Kribi::PAGINATION_UPPER_LIMIT,
      table_name: children_model.table_name,
      human_name: children_model.to_s.underscore.humanize,
      parent_column_name: parent_model_column,
      attributes: calculated_attribute_metadata
    }
  end

  def calculated_parents
    parent_model.all
  end

  # NOTE: For use in editor
  def current_parent_id
    params[parent_model_column] || 1
  end

  # NOTE: For use in editor
  def current_parent
    parent_model.find_by(id: current_parent_id)
  end

  def whitelisted_columns
    children_model.columns.reject do |column|
      Kribi::BLACKLISTED_COLUMN_NAMES.include?(column.name) || (column.name =~ /match_key/)
    end
  end

  def whitelisted_column_names
    whitelisted_columns.map(&:name)
  end

  def permitted_params
    params.permit(whitelisted_column_names)
  end

  # TODO: smells
  # TODO: merge this with permitted_params
  def final_params
    return @final_params if @final_params
    @final_params = params.permit!.dup

    # internal params
    @final_params.delete('controller')
    @final_params.delete('action')
    @final_params.delete('authenticity_token')

    # pagination params
    @final_params.delete('offset')
    @final_params.delete('limit')
    @final_params.delete('sort_order')
    @final_params.delete('sort_by')

    @final_params
  end

  def parent_model
    @parent_model ||= children_model::PARENT_MODEL
  end

  def parent_model_column
    @parent_model_column ||= children_model.parent_model_column
  end

  def children_model
    raise StandardError.new("No children model specified in controller: #{self.class}")
  end

  def paginated_children_model
    offset      = params[:offset] ? params[:offset].to_i : (children_model.count - Kribi::PAGINATION_UPPER_LIMIT) # NOTE: if no offset, show latest records
    offset = offset < 0 ? 0 : offset # NOTE: Prevents negative offsets
    limit       = params[:limit].to_i
    sort_by     = params[:sort_by] || :id
    sort_order  = params[:sort_order] || :asc

    limit = Kribi::PAGINATION_UPPER_LIMIT unless ((1..Kribi::PAGINATION_UPPER_LIMIT) === limit)

    children_model
      .offset(offset)
      .limit(limit)
      .order(sort_by => sort_order)
  end

  # NOTE: Due to datepicker sending different date format
  # TODO: must convert to d/m/y
  def cast_datetimes
    params[:target_datetime] = DateTime.strptime(params[:target_datetime], "%m/%d/%Y %l:%M %p") if params[:target_datetime] && params[:target_datetime].present?
  end
end


# error_messages = @children_instance.errors.messages.map{|k,v| "#{k.to_s.humanize}: #{v.join(", ")}"}
# flash[:warning] = "Could not create new record: #{error_messages.join('; ')}".html_safe
#
  # TODO: enable this
  # def new
  #   render_server_ok(children_model.new)
  # end

  # TODO: enable this
  # def index
  #   @collection = paginated_children_model.all
  #   render_server_ok(@collection)
  # end

  # TODO: enable this
  # def show
  #   @member = children_model.find(params[:id])
  #   render_server_ok(@member)
  # end

  # TODO: enable this
  # def create
  #   @member = children_model.new(final_params)
  #
  #   if @member.save
  #     render_server_ok(@member)
  #   else
  #     render_bad_request(message: 'Could not create record', errors: @member.errors.messages)
  #   end
  # end

  # TODO: enable this
  # def update
  #   @member = children_model.find(params[:id])
  #
  #   if @member.update(final_params)
  #     render_server_ok(@member)
  #   else
  #     render_bad_request(message: 'Could not update record', errors: @member.errors.messages)
  #   end
  # end

  # TODO: enable this
  # def destroy
  #   @member = children_model.find(params[:id])
  #
  #   if @member.destroy
  #     render_server_ok('Successfully deleted record')
  #   else
  #     render_bad_request(message: 'Could not delete record', errors: @member.errors.messages)
  #   end
  # end

  # TODO: enable this
  # def metadata
  #   render_server_ok(calculated_metadata)
  # end

  # TODO: enable this
  # def parents
  #   render_server_ok(calculated_parents)
  # end
