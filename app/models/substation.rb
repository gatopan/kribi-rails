class Substation < ActiveRecord::Base
  has_many :substation_readings
  validate :only_1_check

  private

  def only_1_check
    return if self.class.count < 1
    errors.add :base, "Only 1 #{self.class.to_s.titleize}s allowed"
  end
end
