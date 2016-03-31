class AbstractEventController < ApplicationController
  skip_before_action :verify_authenticity_token

  # TODO: update old records
  def editor
    if request.post?
      @children_instance = children_model.create(editor_params)

      if @children_instance.save
        flash[:success] = 'Sucessfully created new record'
      else
        error_messages = @children_instance.errors.messages.map{|k,v| "#{k.to_s.humanize}: #{v.join(", ")}"}

        flash[:warning] = [
          "Could not created new record:",
          *error_messages
        ].join("<br/>").html_safe
      end
    end

    @children_instance ||= children_model.new

    params[:offset] ||= children_model.count - Kribi::PAGINATION_UPPER_LIMIT
    params[:offset] = 0 if params[:offset].to_i < 1 # NOTE: Prevents negative offsets

    current_parent_id = params[parent_model_column] || 1
    @current_parent = parent_model.find(current_parent_id)

    @parents = parents
    @children =
      paginated_children_model
      .where(parent_model_column => current_parent_id) # TODO: convert to use filters scope
    @metadata = metadata

    render './event_editor.html.erb'
  end

  private

  # def index
  #   @event = paginated_children_model.all
  #   render json: @event
  # end

  # def show
  #   @event = children_model.find(params[:id])
  #   render json: @event
  # end

  # def create
  #   @event = children_model.new(permitted_params)
  #
  #   if @event.save
  #     render json: @event
  #   else
  #     render json: {
  #       message: 'Could not create record', errors: @event.errors.messages }, status: 400
  #   end
  # end

  # def update
  #   @event = children_model.find(params[:id])
  #
  #   if @event.update(permitted_params)
  #     render json: @event
  #   else
  #     render json: { message: 'Could not update record', errors: @event.errors.messages }, status: 400
  #   end
  # end

  # TODO: Implement this
  # def destroy
  #   raise StandardError.new("Not implemented")
  # end

  # TODO: move this to abstract model
  def metadata
    @metadata ||=
      {
      total_records_count: children_model.count,
      pagination_records_counters: children_model.group(parent_model_column).count,
      pagination_upper_limit: Kribi::PAGINATION_UPPER_LIMIT,
      table_name: children_model.table_name,
      human_name: children_model.to_s.underscore.humanize,
      parent_column_name: parent_model_column,
      attributes: whitelisted_columns
        .select do |column| # NOTE: Converted parent model column to implicit
          column.name != parent_model_column
        end.map do |column|
        # TODO: Implement enum explicit UI names
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
    }
  end

  def parents
    @parents = parent_model.all
  end

  def editor_params
    params.permit(
      :equipment,
      :bank,
      :cylinder,
      :alarm,
      :type,
      :context,
      :owner,
      :light_fuel_oil_consumption_type,
      :mean_load,
      :observations,
      :target_datetime,
      :target_ending_datetime,
      :engine_id
    )
  end

  def children_model
    raise StandardError.new("No children model specified in controller: #{self.class}")
  end

  def permitted_params
    params.permit(whitelisted_column_names)
  end

  # Uses regex filtering
  def whitelisted_columns
    children_model.columns.reject do |column|
      column.name =~ /#{Kribi::BLACKLISTED_COLUMN_NAMES.join('|')}/
    end
  end

  def whitelisted_column_names
    whitelisted_columns.map(&:name)
  end

  def paginated_children_model
    offset      = params[:offset].to_i
    limit       = params[:limit].to_i
    sort_by     = params[:sort_by] || :id
    sort_order  = params[:sort_order] || :asc

    limit = Kribi::PAGINATION_UPPER_LIMIT unless ((1..Kribi::PAGINATION_UPPER_LIMIT) === limit)

    children_model
      .offset(offset)
      .limit(limit)
      .order(sort_by => sort_order)
  end

  def parent_model_column
    @parent_model_column ||= children_model.parent_model_column
  end

  def parent_model
    @parent_model ||= children_model::PARENT_MODEL
  end
end
