class EngineStartEventsController < AbstractEventController

  private

  def children_model
    @children_model ||= EngineStartEvent
  end
end
