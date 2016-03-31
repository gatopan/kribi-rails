class EngineStatusChangeEventsController < AbstractEventController

  private

  def children_model
    @children_model ||= EngineStatusChangeEvent
  end
end
