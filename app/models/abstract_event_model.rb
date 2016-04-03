class AbstractEventModel < AbstractModel
  self.abstract_class = true

  def self.abstract_bootloader
    return if self.abstract_class
    super
  end

  def self.target_day
    self.APPROVED.last.try(:target_datetime) || DateTime.now
  end
end
