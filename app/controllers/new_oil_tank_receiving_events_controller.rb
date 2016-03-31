class NewOilTankReceivingEventsController < AbstractEventController

  private

  def children_model
    @children_model ||= NewOilTankReceivingEvent
  end
end
