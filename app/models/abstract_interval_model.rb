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

  def difference(column_name)
    # return unless counter_value_exist?(real_value_column_name)
    return 0.0 unless previous_record
    self.send(column_name) - previous_record.send(column_name)
  end

  def calculate_relative_logic
    self.class.relative_counter_value_columns.each do |column|
      counter_value_column_name = column.fetch(:counter_value_column_name)
      absolute_value_column_name = column.fetch(:absolute_value_column_name)
      real_value_column_name = counter_value_column_name.to_s.sub('counter', 'real').to_sym
      counter_offset_column_name = counter_value_column_name.to_s.sub('value', 'offset').to_sym

      real_value = [
        previous_record ? previous_record.send(real_value_column_name) : 0.0,
        self.send(counter_value_column_name),
        self.send(counter_offset_column_name)
      ].sum

      self.send("#{real_value_column_name}=", real_value)

      absolute_value = difference(real_value_column_name)
      # binding.pry if (self.id == 3) && (self.engine_id == 1)
      self.send("#{absolute_value_column_name}=", absolute_value)
    end
  end

  ## VALIDATORS




  ## HELPERS

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


  # def counter_value_exist?(counter_value)
  #   begin
  #     !!(self.send(counter_value))
  #   rescue
  #     raise StandardError.new('self.class::COUNTER_VALUES_COLUMNS is misconfigured')
  #   end
  # end
  #

  def congruence
    return unless previous_records.any?

    self.class::relative_counter_value_columns.each do |counter_value_column|
      column_name = counter_value_column.fetch(:counter_value_column_name)
      maximum_interval_difference = counter_value_column.fetch(:maximum_interval_difference)
      minimum_interval_difference = counter_value_column.fetch(:minimum_interval_difference)

      if self.send(column_name) < previous_records.maximum(column_name)
        errors.add column_name, 'must be equal or greater than previous records'
      end

      if difference(column_name) > maximum_interval_difference
        errors.add column_name, 'is above the maximum allowed difference.'
      end

      if difference(column_name) < minimum_interval_difference
        errors.add column_name, 'is below the minimum allowed difference.'
      end
    end
  end
end
