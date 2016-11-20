class EngineTripEventsController < AbstractEventController

  private

  def children_model
    @children_model ||= EngineTripEvent
  end
end