module MatchKeyGenerators
  ALLOWED_MATCH_KEY_TYPES = [
    :standard_daily,
    :standard_weekly,
    :standard_monthly,
    :standard_quarter,
    :standard_yearly,
    :customer_monthly
  ]
  extend ActiveSupport::Concern

  included do
    def self.match_key_types=(match_key_types)
      @@match_key_types = match_key_types
    end

    def self.match_key_types
      @@match_key_types
    rescue
      raise StandardError.new("Match key types should be defined, please call generate_match_keys_for in #{self.class}")
    end

    def self.match_key_column_names
      match_key_types.map{|match_key_type| "match_key_#{match_key_type}"}
    end

    def self.generate_match_keys_for(*match_key_types)
      self.match_key_types = match_key_types
      check_match_key_types_congruence
      check_match_key_types_columns_exist
    end

    def self.check_match_key_types_congruence
      unless ALLOWED_MATCH_KEY_TYPES.to_set.superset?(match_key_types.to_set)
        raise StandardError.new("Incompatible match keys")
      end
    end

    def self.check_match_key_types_columns_exist
      unless self.column_names.to_set.superset?(match_key_column_names.to_set)
        raise StandardError.new("Missing one of the following match key columns inside #{self.table_name} table: #{match_key_column_names.join(', ')}.")
      end
    end

    def generate_match_key_types
      return unless self.send(self.class::DATETIME_COLUMN)
      self.class.match_key_types.each do |match_key_type|
        self.send("match_key_#{match_key_type}=", calculated_match_key_for(match_key_type))
      end
    end

    def calculated_match_key_for(match_key_type)
      "#{date_fragment(match_key_type)}#{parent_fragment}#{types_fragments.join}"
    end

    def date_fragment(match_key_type)
      self.send("calculate_match_key_date_fragment_#{match_key_type}")
    end

    def parent_fragment
      @parent_fragment ||= "P%02d" % self.send(self.class.parent_model_column)
    end

    def types_fragments
      @types_fragments ||= self.class::EXPORTER_CONFIG.fetch(:match_key_types_fragments).map do |type_fragment|
        self.send(type_fragment)
      end
    end

    def match_key_date
      @match_key_date ||= self.send(self.class::DATETIME_COLUMN)
    end

    def match_key_year_number
      @match_key_year_number ||= match_key_date.strftime('%G')
    end

    def match_key_month_number
      @match_key_month_number ||= "%02d" % match_key_date.month
    end

    def match_key_customer_month_number
      # TODO Implement
      # @match_key_customer_month_number ||= "%02d" % match_key_date.month
    end

    def match_key_day_number
      @match_key_day_number ||= "%02d" % match_key_date.day
    end

    def match_key_week_number
      @match_key_week_number ||= "%02d" % match_key_date.to_date.cweek
    end

    def match_key_quarter_number
      @match_key_quarter_number ||= ( ( match_key_date.month - 1 ) / 3 ) + 1
    end

    def calculate_match_key_date_fragment_standard_daily
      "#{match_key_year_number}#{match_key_month_number}#{match_key_day_number}"
    end

    def calculate_match_key_date_fragment_standard_weekly
      "#{match_key_year_number}W#{match_key_week_number}"
    end

    def calculate_match_key_date_fragment_standard_monthly
      "#{match_key_year_number}M#{match_key_month_number}"
    end

    def calculate_match_key_date_fragment_standard_quarter
      "#{match_key_year_number}Q#{match_key_quarter_number}"
    end

    def calculate_match_key_date_fragment_standard_yearly
      "#{match_key_year_number}"
    end

    def calculate_match_key_date_fragment_customer_monthly
      # TODO
      "#{match_key_year_number}C#{match_key_customer_month_number}"
    end
  end
end
