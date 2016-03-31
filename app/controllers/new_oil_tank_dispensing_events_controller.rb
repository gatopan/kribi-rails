class NewOilTankDispensingEventsController < AbstractEventController

  private

  def children_model
    @children_model ||= NewOilTankDispensingEvent
  end
end
