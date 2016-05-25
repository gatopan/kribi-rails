class AbstractIntervalModel < AbstractModel
  self.abstract_class = true
  REQUIRED_ABSOLUTE_COUNTER_VALUES_COLUMN_NAME_KEYS = [
    :name,
  ]

  REQUIRED_RELATIVE_COUNTER_VALUES_COLUMN_NAME_KEYS = [
    :counter_value_column_name,
    :absolute_value_column_name
  ]

  ## CALCULATED FIELDS
  def self.target_day
    intended_day =
      self.PENDING.last.try(DATETIME_COLUMN) ||
      self.REVIEWED.last.try(DATETIME_COLUMN) ||
      self.APPROVED.last.try(DATETIME_COLUMN).try(:+, 1.day)

    return unless intended_day

    # prevent future dates
    if intended_day > 1.day.from_now.beginning_of_day
      self.APPROVED.last.try(DATETIME_COLUMN)
    else
      intended_day
    end
  end


  # CALLBACKS

  # NOTE: Column convention is hardcoded below
  def calculate_relative_logic
    self.class.relative_counter_value_columns.each do |column|
      counter_value_column_name = column.fetch(:counter_value_column_name)
      real_value_column_name = counter_value_column_name.to_s.sub('counter', 'real').to_sym
      absolute_value_column_name = column.fetch(:absolute_value_column_name)

      current_record_real_value = calculated_real_value_for(column)

      self.send("#{real_value_column_name}=", current_record_real_value)
      self.send("#{absolute_value_column_name}=", current_record_real_value)
    end
  end

  ## VALIDATORS

  def congruence
    return unless previous_record
    self.class::relative_counter_value_columns.each do |column|
      counter_value_column_name = column.fetch(:counter_value_column_name)
      maximum_interval_difference = column.fetch(:maximum_interval_difference)
      minimum_interval_difference = column.fetch(:minimum_interval_difference)

      current_record_real_value = calculated_real_value_for(column)

      if current_record_real_value > maximum_interval_difference
        errors.add counter_value_column_name, 'is above the maximum allowed difference.'
      end

      if current_record_real_value < minimum_interval_difference
        errors.add counter_value_column_name, 'is below the minimum allowed difference.'
      end
    end
  end

  ## HELPERS

  def self.is_resettable?
    column_names.any?{|name| name =~ /offset/ }
  end

  # NOTE: Column convention is hardcoded below
  def calculated_real_value_for(column)
    counter_value_column_name = column.fetch(:counter_value_column_name)
    counter_offset_column_name = counter_value_column_name.to_s.sub('value', 'offset').to_sym

    previous_record_counter_value = previous_record ? previous_record.send(counter_value_column_name) : 0.0
    current_record_counter_value = self.send(counter_value_column_name)
    current_record_counter_offset = self.send(counter_offset_column_name)

    current_record_counter_value + current_record_counter_offset - previous_record_counter_value
  end

  # TODO rename this and plant oil refs
  def difference(column_name)
    return 0.0 unless previous_record
    self.send(column_name) - previous_record.send(column_name)
  end

  ## INITIALIZER

  def self.absolute_counter_value_columns
    self::COUNTER_VALUES_COLUMNS.select do |column|
      column.fetch(:type) == :absolute
    end
  end

  def self.relative_counter_value_columns
    self::COUNTER_VALUES_COLUMNS.select do |column|
      column.fetch(:type) == :relative
    end
  end

  def self.required_column_names
    required_column_names = []

    absolute_counter_value_columns.each do |column|
      REQUIRED_ABSOLUTE_COUNTER_VALUES_COLUMN_NAME_KEYS.map do |key|
        required_column_names << column.fetch(key)
      end
    end

    relative_counter_value_columns.each do |column|
      REQUIRED_RELATIVE_COUNTER_VALUES_COLUMN_NAME_KEYS.map do |key|
        required_column_names << column.fetch(key)
      end
    end

    required_column_names
  end

  def self.columns_congruence_check
    actual_column_names_set = self.column_names.map(&:to_sym).to_set
    required_column_names_set = required_column_names.to_set

    column_names_difference = required_column_names_set.difference(actual_column_names_set)

    if column_names_difference.any?
      raise StandardError.new("Missing column names: #{column_names_difference.to_a.join(', ')} for model: #{self}, table name: #{self.table_name}")
    end

    # TODO: Implement default value check and index check
    # TODO: match_key check too
  end

  def self.abstract_bootloader
    return if self.abstract_class
    columns_congruence_check
    validate :congruence, on: :congruence
    before_save :calculate_relative_logic
    super
  end
end
