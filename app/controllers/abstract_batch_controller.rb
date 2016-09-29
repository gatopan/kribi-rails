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
    :target_day
  )

  def show
    if target_day
      @target_datetimes = target_datetimes
      @parents = parents
      create_children_if_they_do_not_exist
      @children = children
      check_extra_children_validity
      render template: 'batches/show.html.erb'
    else
      render template: 'batches/target_day_selection.html.erb'
    end
  end

  def update
    @children = children
    @parents = parents
    @target_datetimes = target_datetimes
    perform_update_with_groupings
    check_extra_children_validity
    flash[:success] = "Sucessfully updated #{children_model.table_name.titleize} values"
    render template: 'batches/show.html.erb'
  end

  def elevate
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
      return redirect_to self.send("batch_show_#{controller_name}_index_url")
    end

    ActiveRecord::Base.transaction do
      children.each do |child|
        child.update!(status: intended_status)
      end
    end

    service = Kribi::Exporter::Performer.new(:all)
    service.perform

    flash[:success] = "Sucessfully updated status to #{intended_status.downcase} on all records."
    flash.keep
    return redirect_to self.send("batch_show_#{controller_name}_index_url")
  end

  def previous_day_target_datetimes
    @previous_day_target_datetimes ||= target_datetimes.map{|td| td - 1.day}.last(1)
  end

  def previous_day_children
    @previous_day_children ||= children_model.where(
      association_name(parent_model, :singular) => parents,
      children_model_datetime_column => previous_day_target_datetimes,
    ).order(id: :asc).last(1 * parents.length)
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
    @target_day ||=
      if params[:target_day]
        target_day_datetime = params[:target_day].to_datetime

        if target_day_datetime >= DateTime.now
          raise StandardError.new("Target Day cannot be in the future.")
        end

        if children_model.any?
          if target_day_datetime < children_model.first.target_datetime
            raise StandardError.new("Target Day cannot be before first record.")
          end

          target_day_datetime
        else
          target_day_datetime
        end
      else
        children_model.target_day
      end
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

    parent_children_grouping.each do |parent, children|
      children.each do |child|
        attributes = collection_params[child.id.to_s] # TODO: use a more natural data structure for params
        child.update(attributes)
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
