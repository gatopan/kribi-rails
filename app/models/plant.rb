class Plant < ApplicationRecord
  has_many :plant_light_fuel_oil_readings
  has_many :plant_gross_capacity_readings
  has_many :plant_reference_condition_readings
  has_many :plant_declared_capacity_readings

  validate :only_one_check

  private

  def only_one_check
    return if self.class.count < 1
    errors.add :base, "Only one #{self.class.to_s.titleize} allowed"
  end
end
