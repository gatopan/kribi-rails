class ServiceOilTankReceivingEventsController < AbstractEventController

  private

  def children_model
    @children_model ||= ServiceOilTankReceivingEvent
  end
end
