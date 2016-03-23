module Kribi
  module Exporter
    ALLOWED_MIDDLE_RECORD_MODELS = [
      EngineStatusChangeEvent,
      EngineTripEvent
    ]

    extend ActiveSupport::Autoload

    autoload :Performer
    autoload :MiddleRecordGenerator
  end
end
