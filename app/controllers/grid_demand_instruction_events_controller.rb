class GridDemandInstructionEventsController < AbstractEventController

  private

  def children_model
    @children_model ||= GridDemandInstructionEvent
  end
end
