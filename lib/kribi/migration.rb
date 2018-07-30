require 'digest/sha1'

module Kribi
  class Migration < ActiveRecord::Migration[5.1]
    MATCH_KEY_COLUMN_NAMES = [
      :standard_daily,
      :standard_weekly,
      :standard_monthly,
      :standard_quarter,
      :standard_yearly,
      :customer_monthly
    ].map do |match_key_type|
      "match_key_#{match_key_type}"
    end

    # TODO: Implement and migrate this
    def create_match_keys_for(t)
      table_name_hash = Digest::SHA1.hexdigest(t.name)

      MATCH_KEY_COLUMN_NAMES.each do |column_name|
        column_name_hash = Digest::SHA1.hexdigest(column_name)
        t.send(:string, column_name, index: { name: "index_#{table_name_hash[0..25]}_in_#{column_name_hash[0..25]}"[0..62]})
      end
    end

    # Includes counter value, counter offset, and real value columns
    def create_relative_counter_value_columns(table, counter_value_column_name)
      table_name_hash = Digest::SHA1.hexdigest(table.name)

      [
        counter_value_column_name.to_s,
        counter_value_column_name.to_s.sub('counter', 'real'),
        counter_value_column_name.to_s.sub('value', 'offset'),
      ].each do |column_name|
        column_name_hash = Digest::SHA1.hexdigest(column_name)

        table.float column_name, default: 0
        name = "index_#{table_name_hash[0..25]}_#{column_name_hash[0..25]}"
        table.index column_name, name: name
      end
    end
  end
end
