class EngineOperationEventsController < AbstractEventController

  private

  def children_model
    @children_model ||= EngineOperationEvent
  end
end