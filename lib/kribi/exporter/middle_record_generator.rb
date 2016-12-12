module Kribi
  module Exporter

    # Generates middle records in case for export to excel format
    # The purpose of this class is to slice events into 24 (daily) pieces
    class MiddleRecordGenerator
      attr_accessor(
        :model,
        :middle_records
      )

      def initialize(model)
        @model = model
        @middle_records = []
      end

      def perform
        return [] unless ALLOWED_MIDDLE_RECORD_MODELS.include?(model)

        case model.to_s
        when "EngineStatusChangeEvent"
          model::PARENT_MODEL.all.each do |parent_model|
            parent_id = parent_model.id
            children = model.where(model.parent_model_column => parent_id).order(:id).to_a
            next unless children.any?

            # Select first child to ease data handling
            previous_child = children.first

            # Create last child to ease data handling
            final_child = generate_final_child(model, parent_id)
            children.push(final_child)

            children.each_with_index do |current_child, index|
              next if index == 0

              previous_child_day = days_since_y2k(previous_child.target_datetime)
              current_child_day = days_since_y2k(current_child.target_datetime)

              (previous_child_day..current_child_day).each do |block_day|
                block_day_date = y2k_days_to_date(block_day)

                duration_in_hours =
                  if current_child_day == previous_child_day # if starts and ends on same day
                    ( current_child.target_datetime - previous_child.target_datetime)/(60 * 60)
                  elsif previous_child_day == block_day # if first day
                    24 + (block_day_date - previous_child.target_datetime)/(60 * 60)
                  elsif current_child_day == block_day # if last day
                    (current_child.target_datetime - block_day_date)/(60 * 60)
                  else
                    24
                  end

                middle_record_source                  = current_child.dup
                middle_record                         = EngineStatusChangeExportEvent.new
                middle_record.attributes              = middle_record_source.attributes
                middle_record.engine_mode             = previous_child.engine_mode
                middle_record.derating_mode           = previous_child.derating_mode
                middle_record.duration_in_hours       = duration_in_hours
                middle_record.target_datetime         = block_day_date
                middle_record.APPROVED!

                unless middle_record.save
                  raise StandardError.new('Unable to save middle record')
                end

                middle_records.push(middle_record)
              end

              previous_child = current_child
            end

            middle_records.last.destroy! # remove final record to prevent record with empty duratin to show in the report
          end
        end
      end

      private

      def generate_final_child(model, parent_id)
        case model.to_s
        when "EngineStatusChangeEvent"
          model.new(
            model.parent_model_column => parent_id,
            engine_mode: model.engine_modes.values.sample,
            target_datetime: remove_hours(Time.now.utc)
          )
        else
          raise StandardError.new("Model not implemented for middle records: #{model}")
        end
      end

      # Time helpers

      # FIXME: bug when that strips minutes and seconds from datetime
      def remove_hours(datetime)
        Time.utc(datetime.year, datetime.month, datetime.day)
      end

      def days_since_y2k(datetime)
        ((remove_hours(datetime) - Time.utc(2000))/(60*60*24)).to_i
      end

      def y2k_days_to_date(days)
        Time.at(days * 60 * 60 * 24 + Time.utc(2000).to_i).utc
      end
    end
  end
end
