class AbstractModel < ActiveRecord::Base
  self.abstract_class = true

  DATETIME_COLUMN = :target_datetime

  include MatchKeyGenerators

  def self.target_day
    raise StandardError.new('Must implement')
  end

  def self.all_children
    all_children = self.descendants
    all_children.reject!{|model| model.abstract_class}
    all_children.reject!{|model| model.to_s =~ /Export/}
    all_children
  end

  def self.parent_model_string
    self::PARENT_MODEL.to_s.underscore
  end

  def self.parent_model_column
    "#{parent_model_string}_id"
  end

  def parent_record
    self.send(self.class.parent_model_string)
  end

  def parent_children_records
    parent_model_string = self.class.parent_model_string
    @parent_children_records ||= self.class.where(parent_model_string => self.parent_record)
  end

  def previous_records
    if persisted?
      parent_children_records.where("id < (?)", self.id).order(:id)
      # .limit((1440 / self.class::INTERVAL_IN_MINUTES) * 2) # last 2 days
    else
      parent_children_records.order(:id)
    end
  end

  def previous_record
    previous_records.last
  end

  def remove_seconds_from_datetime_column
    return unless self.send("#{self.class::DATETIME_COLUMN}")
    self.send("#{self.class::DATETIME_COLUMN}=", self.send(self.class::DATETIME_COLUMN).change(sec: 0))
  end

  def self.abstract_bootloader
    return if self.abstract_class
    generate_match_keys_for(
      :standard_daily,
      :standard_weekly,
      :standard_monthly,
      :standard_quarter,
      :standard_yearly,
      :customer_monthly
    )

    before_validation :generate_match_key_types
    before_validation { self.status ||= :PENDING }
    before_validation :remove_seconds_from_datetime_column

    enum status: {
      PENDING: 0,
      REVIEWED: 10,
      APPROVED: 20
    }

    belongs_to parent_model_string.to_sym

    validates parent_model_string.to_sym, presence: true
    validates :target_datetime, presence: true
    validates :status, presence: true
  end
end
