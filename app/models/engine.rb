class Engine < ApplicationRecord
  has_many :engine_gas_readings
  has_many :engine_light_fuel_oil_readings
  has_many :engine_energy_readings
  has_many :engine_emission_readings
  has_many :engine_running_time_readings

  has_many :engine_lube_oil_dispensing_events
  has_many :engine_cooling_water_dispensing_events
  has_many :engine_status_change_events
  has_many :service_oil_tank_receiving_events

  validate :only_13_check

  private

  def only_13_check
    return if self.class.count < 13
    errors.add :base, "Only 13 #{self.class.to_s.titleize}s allowed"
  end
end
