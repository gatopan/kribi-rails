class AbstractBatchController < ApplicationController
  helper_method(
    :parent_model,
    :children_model,
    :children_attributes,
    :association_name,
    :parents,
    :previous_day_target_datetimes,
    :previous_day_children,
    :target_datetimes,
    :children,
    :target_day,
    :combined_children,
    :combined_target_datetimes
  )

  # NOTE: Basically update selected batch plus future batches records to PENDING
  # status
  def handle_regression
    return if params[:previous_action] == 'elevate'
    if params[:target_day]
      # find intended status
      intented_status = children_model.statuses['PENDING']

      # find affected records
      starting_id = children.minimum(:id)
      affected_records = children_model.where("id >= (?)", starting_id)

      # perform update
      ActiveRecord::Base.transaction do
        affected_records.each do |record|
          record.update!(status: intented_status)
        end
      end
    end
  end

  def combined_target_datetimes
    @combined_target_datetimes ||= previous_day_target_datetimes + target_datetimes
  end

  def combined_children
    @combined_children ||= previous_day_children + children
  end

  def batch_size
    target_datetimes.length * parents.length
  end

  def first_pending_batch
    return unless children_model.PENDING.any?
    children_model.PENDING.first(batch_size)
  end

  def first_pending_batch_target_datetime
    return unless first_pending_batch
    first_pending_batch.last.target_datetime
  end

  def batch_show
    if params.key?(:target_day) && (params[:target_day] == "")
      return render_bad_request('Must submit a target day')
    end

    @body_class = 'batch-show'

    @target_datetimes = target_datetimes
    @parents = parents

    # Redirects to first pending batch there exist several pending batches due
    # to previous regression
    if (children_model.PENDING.count > batch_size) && (target_day != first_pending_batch_target_datetime)
      flash[:warning] = "PENDING records at #{first_pending_batch_target_datetime.utc.strftime("%d/%m/%Y")} need to be APPROVED first."
      flash.keep
      return redirect_to(
        controller: params[:controller],
        action: 'batch_show',
        target_day: first_pending_batch_target_datetime.utc.strftime("%d/%m/%Y")
      )
    end

    create_children_if_they_do_not_exist
    @children = children
    handle_regression
    check_extra_children_validity
    render template: 'batch_show.html.erb'
  end

  def batch_update
    @body_class = 'batch-update'

    @children = children
    @parents = parents
    @target_datetimes = target_datetimes
    perform_update_with_groupings
    check_extra_children_validity
    flash[:success] = "Sucessfully updated #{children_model.table_name.titleize} values"
    flash.keep
    redirect_to(
      controller: params[:controller],
      action: 'batch_show',
      target_day: target_day.utc.strftime("%d/%m/%Y")
    )
  end

  def batch_elevate
    unless intended_status = params[:intended_status]
      return render_bad_request('Must submit a intended status')
    end

    unless children_model.statuses.keys.include?(intended_status)
      return render_bad_request('Must submit a valid intended status')
    end

    # TODO: Add approver locks

    normal_validation_result = children.all?{|child| child.valid?}
    extra_validation_result = children.all?{|child| child.valid?(:congruence)}

    unless normal_validation_result && extra_validation_result
      flash[:warning] = 'Some records have not yet passed validations.'
      flash.keep
      return redirect_to self.send("#{children_model.table_name}_show_path")
    end

    ActiveRecord::Base.transaction do
      children.each do |child|
        child.update!(status: intended_status)
      end
    end

    service = Kribi::Exporter::Performer.new(:all)
    service.perform

    if intended_status == "APPROVED"
      flash[:success] = "Sucessfully updated status to #{intended_status.downcase} on all records.<br>You are up to date!"
    else
      flash[:success] = "Sucessfully updated status to #{intended_status.downcase} on all records."
    end

    flash.keep

    original_target_day = target_day || DateTime.now.utc

    if (original_target_day + 1.day) >= DateTime.now
      target_day = original_target_day
    else
      target_day = original_target_day + 1.day
    end

    redirect_to(
      controller: params[:controller],
      action: 'batch_show',
      target_day: target_day.strftime("%d/%m/%Y"),
      previous_action: 'elevate'
    )
  end

  def previous_day_target_datetimes
    @previous_day_target_datetimes = [] if target_day == children_model.first.target_datetime
    @previous_day_target_datetimes ||= children_model.count > (target_datetimes.count * parents.count) ? target_datetimes.map{|td| td - 1.day}.last(1) : []
  end

  def previous_day_children
    @previous_day_children ||= children_model.where(
      association_name(parent_model, :singular) => parents,
      children_model_datetime_column => previous_day_target_datetimes,
    ).order(id: :asc)
  end

  def target_datetimes
    return [] unless target_day
    return @target_datetimes if @target_datetimes
    frequency = 1440 / children_model::INTERVAL_IN_MINUTES

    @target_datetimes = frequency.times.map do |iteration_number|
      minute_number = children_model::INTERVAL_IN_MINUTES * iteration_number
      hour = minute_number / 60
      minute = minute_number % 60

      Time.zone.local(
        target_day.year,
        target_day.month,
        target_day.day,
        hour,
        minute
      ).to_datetime
    end
  end

  def target_day
    return children_model.target_day unless params[:target_day]

    # TODO: enforce only d/m/y is being used, do not allow hour/minutes/seconds
    target_day_datetime = params[:target_day].to_datetime

    if target_day_datetime >= DateTime.now
      raise StandardError.new("Target Day cannot be in the future.")
    end

    unless children_model.any?
      return target_day_datetime
    end

    if target_day_datetime < children_model.first.target_datetime
      raise StandardError.new("Target Day cannot be before first record.")
    end

    return target_day_datetime
  end

  def association_name(model, type)
    model.to_s.underscore.send("#{type}ize")
  end

  def parents
    @parents ||= parent_model.all
  end

  def children
    @children ||= children_model.where(
      association_name(parent_model, :singular) => parents,
      children_model_datetime_column => target_datetimes,
    ).order(children_model_datetime_column, children_model.parent_model_column)
  end

  def create_children_if_they_do_not_exist
    parents.each do |parent|
      target_datetimes.each do |target_datetime|
        children_model.where(
          association_name(parent_model, :singular) => parent,
          children_model_datetime_column => target_datetime,
        ).first_or_create
      end
    end
    # TODO: verify there's a child for each parent within current constraints
  end

  def check_extra_children_validity
    children.each do |child|
      child.valid?(:congruence)
    end
  end

  def perform_update_with_groupings
    parent_children_grouping = children.group_by do |child|
      child.send(association_name(parent_model, :singular))
    end

    ActiveRecord::Base.transaction do
      parent_children_grouping.each do |parent, children|
        children.each do |child|
          attributes = collection_params[child.id.to_s] # TODO: use a more natural data structure for params
          child.update(attributes)
        end
      end
    end
  end

  def collection_params
    params.require(association_name(children_model, :plural).to_sym).permit!
  end

  def children_model_datetime_column
    :target_datetime
  end
end
