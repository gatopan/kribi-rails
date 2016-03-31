module ReadingTimingRules
  module Hourly
    extend ActiveSupport::Concern

    included do
      # validates :target_datetime, presence: true, uniqueness: true
    end
  end
end
