class NewOilTankReceivingEvent < AbstractEventModel
  PARENT_MODEL = NewOilTank
  CUSTOM_NAME = nil
  EXPORTER_CONFIG = {
    match_key_types_fragments: [],
    mappings: [
      {
        query: {
          type: :aggregate,
          fragment: 'sum(quantity_in_liters) as quantity_in_liters_sum'
        },
        destination: {
          type: :excel,
          template: false,
          filename_prefix: 'kpp_kpi_report',
          worksheet_name: self.table_name
        }
      },
      {
        query: {
          type: :dump,
        },
        destination: {
          type: :excel,
          template: false,
          filename_prefix: "#{self.table_name}_dump",
          worksheet_name: self.table_name
        }
      }
    ]
  }
  CALCULATED_FIELD_NAMES = [
    'quantity_in_liters'
  ]
  abstract_bootloader()

  before_validation do
    CALCULATED_FIELD_NAMES.each do |calculated_field_name|
      result = self.send("calculated_#{calculated_field_name}")
      self.send("#{calculated_field_name}=", result)
    end
  end

  validates :counter_value, {
    presence: true,
    numericality: {
      greater_than_or_equal_to: 0,
      less_than: 99999 # TODO: get real counter value max value
    }
  }

  validates :quantity_in_liters, {
    presence: true,
    numericality: {
      greater_than_or_equal_to: 0,
      less_than_or_equal_to: 80000
    }
  }

  validate :counter_value_congruence

  private

  def previous_record
    parent_children_records.last
  end

  def counter_value_congruence
    return unless counter_value
    return unless previous_record
    if counter_value < previous_record.counter_value
      errors.add :counter_value, 'cannot be lower than previous record counter value'
    end
  end

  def calculated_quantity_in_liters
    return unless counter_value
    if previous_record
      counter_value - previous_record.counter_value
    else
      counter_value
    end
  end
end
