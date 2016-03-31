class EngineCoolingWaterDispensingEventsController < AbstractEventController

  private

  def children_model
    @children_model ||= EngineCoolingWaterDispensingEvent
  end
end
