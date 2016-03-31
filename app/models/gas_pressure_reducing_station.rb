class GasPressureReducingStation < ActiveRecord::Base
  has_many :gas_pressure_reducing_station_readings
  has_many :gas_nomination_readings

  validate :only_one_check

  private

  def only_one_check
    return if self.class.count < 1
    errors.add :base, "Only one #{self.class.to_s.titleize} allowed"
  end
end
