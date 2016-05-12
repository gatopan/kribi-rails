class AbstractEventModel < AbstractModel
  self.abstract_class = true

  def self.abstract_bootloader
    return if self.abstract_class
    validate :target_datetime_congruence
    super
  end

  def target_datetime_congruence
    return unless previous_record

    if self.target_datetime < previous_record.target_datetime
      errors.add :target_datetime, "must be equal or later than previous record's"
    end

    tomorrow = DateTime.now + 1.day
    start_of_tomorrow = DateTime.new(tomorrow.year, tomorrow.month, tomorrow.day)

    if self.target_datetime > start_of_tomorrow
      errors.add :target_datetime, 'must be before tomorrow'
    end
  end

  def self.target_day
    self.APPROVED.last.try(:target_datetime) || DateTime.now
  end
end
