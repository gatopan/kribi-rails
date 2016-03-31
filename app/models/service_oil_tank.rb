class ServiceOilTank < ActiveRecord::Base
  has_many :service_oil_tank_dispensing_events
  has_many :service_oil_tank_receiving_events

  validate :only_one_check

  private

  def only_one_check
    return if self.class.count < 1
    errors.add :base, "Only one #{self.class.to_s.titleize} allowed"
  end
end
