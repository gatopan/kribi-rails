class Feeder < ActiveRecord::Base
  has_many :feeder_readings

  validate :only_five_check

  private

  def only_five_check
    return if self.class.count < 5
    errors.add :base, "Only five #{self.class.to_s.titleize} allowed"
  end
end
