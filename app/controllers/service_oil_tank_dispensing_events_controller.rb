class ServiceOilTankDispensingEventsController < AbstractEventController

  private

  def children_model
    @children_model ||= ServiceOilTankDispensingEvent
  end
end
