module Kribi
  class Migration < ActiveRecord::Migration
    # TODO: Implement and migrate this
    def create_match_keys_for(table)
      raise StandardError.new("Not implemented")
    end

    # Includes counter value, counter offset, and real value columns
    def create_relative_counter_value_columns(table, counter_value_column_name)
      [
        counter_value_column_name.to_s,
        counter_value_column_name.to_s.sub('counter', 'real'),
        counter_value_column_name.to_s.sub('value', 'offset'),
      ].each do |column_name|
        table.float column_name, default: 0
        table.index column_name, name: "index_#{table.name[0..32]}_#{column_name}"
      end
    end
  end
end
