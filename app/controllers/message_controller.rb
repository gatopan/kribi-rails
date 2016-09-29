class MessageController < ApplicationController

  def success_messages
    @success_messages || []
  end

  def failure_messages
    @failure_messages || []
  end

  def error_messages
    @error_messages || []
  end

  def message
    params.slice(:context, :content)
  end

  def context
    context = message.fetch(:context)

    if context.kind_of? Hash
      context
    else
      raise 'context type must be a hash'
    end
  end

  def content
    content = message.fetch(:content)

    if content.kind_of? Array
      content
    else
      raise 'content type must be an array'
    end
  end

  def resource
    resource = context.fetch(:resource)

    if resource.kind_of? String
      resource
    else
      raise 'resource type must be an string'
    end
  end

  def unsafe_model
    resource.classify.constantize
  rescue NameError
    raise "unsupported resource submitted: #{resource}"
  end

  # TODO: Report unsafe model submissions
  def safe_model
    if AbstractModel.descendants.include? unsafe_model
      unsafe_model
    else
      raise "unsupported resource submitted: #{resource}"
    end
  end

  def action
    action = context.fetch(:action)

    if action.kind_of? String
      action
    else
      raise 'action type must be an string'
    end
  end

  def action_name
    action.to_sym
  end

  # TODO: Double check only permitted methods are going through
  def controller_actions
    self.class.instance_methods(false)
  end

  def handler
    if controller_actions.include? action_name
      self.send(action_name)
    else
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  # TODO: Optimize for fewest possible queries
  def collection
    @collection ||=
      case action
      when 'create'
        content.dup.map do |member_attributes|
          safe_model.new(member_attributes)
        end
      when 'read'
        content.dup.map do |member_attributes|
          safe_model.find_by(id: member_attributes.delete(:id))
        end
      when 'update'
        content.dup.map do |member_attributes|
          if record = safe_model.find_by(id: member_attributes.delete(:id))
            record.attributes = member_attributes
          end
        end
      when 'delete'
        content.dup.map do |member_attributes|
          if record = safe_model.find_by(id: member_attributes.delete(:id))
            record
          end
        end
      when 'elevate'
        content.dup.map do |member_attributes|
          if record = safe_model.find_by(id: member_attributes.delete(:id))
            record.status = member_attributes.fetch(:status)
          end
        end
      end
  end

  class CollectionSuccessMessage
    attr_accessor(:collection)
  end

  class CollectionMemberSuccessMessage
    attr_accessor(:collection, :member)
  end

  class CollectionMemberAttrributeSuccessMessage
    attr_accessor(:collection, :member, :attribute)
  end

  class CollectionFailureMessage
    attr_accessor(:collection)
  end

  class CollectionMemberFailureMessage
    attr_accessor(:collection, :member)
  end

  class CollectionMemberAttributeFailureMessage
    attr_accessor(:collection, :member, :attribute)
  end


  def create
    collection = content.map{ safe_model.new }

    begin
      # Attribute Assign
      collection.each_with_index do |member, index|
        attributes = content[index]

        attributes.each do |attribute, value|
          member.send(attribute, value)
        end

        if member.valid?
          success_messages << CollectionMemberAttributeSuccessMessage(collection, member, attribute, value)
        else
          failure_messages << CollectionMemberAttributeFailureMessage(collection, member, attribute, value)
        end
      end

      # Member Persist
      collection.each do |member|
        if kkkkkkkkkk
      end

      # Collection Transaction








      safe_model.transaction do
        content.each do |attributes|
          record = safe_model.new

          attributes.each do |attribute, value|
            if record.send(attribute, value)
              success_messages << CollectionMemberAttrributeSuccessMessage(content, record, attribute, value)
            else
              success_messages << CollectionMemberAttrributeFailureMessage(attribute, value)
            end
          end
        end
      end
    rescue
    end












    content.dup.map do |member_attributes|
      safe_model.new(member_attributes)
    end

    begin
      safe_model.transaction do
        collection.each do |member|
          if member.save
            success_messages << CollectionMemberSuccessMessage.new(member, action)
          else
            member.errors.to_hash.each do |attribute, errors|
              errors.each do |error|
                if attribute == :base
                  failure_messages << CollectionMemberFailureMessage.new(collection, member, error)
                else
                  failure_messages << CollectionMemberAttributeFailureMessage.new(collection, member, attribute, error)
                end
              end
            end
          end
        end

        if failure_messages.any?
          raise ActiveRecord::Rollback
        else
          self.result = :sucess
        end
      end
    rescue
      false
    end


    response[:context][:messages] = messages

    render json: response
  end

  def read
    if collection.length == content.length
      self.result = :success
    else
      # collection level failure
      self.result = :failure
    end
  end

  def update
    return :failure if read_collection == :failure

    begin
      safe_model.transaction do
        unless collection.all?(&:save)
          raise ActiveRecord::Rollback
        end
      end
      self.result = :success
    rescue
      # collection member level failure
      # collection member attribute level failure
      self.result = :failure
    end
  end

  def delete
    return :failure if read_collection == :failure

    begin
      safe_model.transaction do
        unless collection.all?(&:destroy)
          raise ActiveRecord::Rollback
        end
      end
      self.result = :success
    rescue
      # collection member level failure
      # collection member attribute level failure
      self.result = :failure
    end
  end

  def elevate
    return :failure if read_collection == :failure

    begin
      safe_model.transaction do
        unless collection.all?(&:save)
          raise ActiveRecord::Rollback
        end
      end
      self.result = :success
    rescue
      # collection member level failure
      # collection member attribute level failure
      self.result = :failure
    end
  end
end
