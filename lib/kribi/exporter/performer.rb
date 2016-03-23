module Kribi
  module Exporter
    class Performer
      attr_accessor(
        :models,
        :middle_record_models,
        :destination_type
      )

      def initialize(models = :all, destination_type = :excel)
        self.models = (models == :all) ? all_models : models
        @middle_record_models = []
        @destination_type = destination_type
      end

      # TODO: move to root module (Kribi)
      def all_models
        all_models = AbstractModel.descendants
        all_models.reject!{|model| model.abstract_class}
        all_models.reject!{|model| model.to_s =~ /Export/}
        all_models
      end

      def destroy_middle_records
        ALLOWED_MIDDLE_RECORD_MODELS.each do |model|
          middle_record_model =
            begin
              model.to_s.gsub('Event', 'ExportEvent').constantize
            rescue
              nil
            end

          middle_record_model.delete_all
        end
      end

      def generate_middle_records
        if ALLOWED_MIDDLE_RECORD_MODELS.to_set.intersect?(models.to_set)
          models.each do |model|
            middle_record_model =
              begin
                model.to_s.gsub('Event', 'ExportEvent').constantize
              rescue
                nil
              end

            if middle_record_model
              generator = MiddleRecordGenerator.new(model)
              generator.perform
              self.middle_record_models << middle_record_model
            end
          end

          self.models = self.models + middle_record_models
        end
      end

      def perform
        generate_middle_records()

        models.each do |model|
          relation                = model.APPROVED
          match_key_column_names  = model.match_key_column_names
          mappings                = model::EXPORTER_CONFIG.fetch(:mappings)

          selected_type_mappings = mappings.select do |mapping|
            mapping.fetch(:destination).fetch(:type) == destination_type
          end

          case destination_type
          when :excel
            selected_type_mappings.each do |mapping|
              query           = mapping.fetch(:query)
              destination     = mapping.fetch(:destination)
              type            = query.fetch(:type)
              query_output    = []

              case type
              when :aggregate
                query_fragment  = query.fetch(:fragment)
                periods_results = []

                match_key_column_names.each do |match_key_column_name|
                  match_fragment = "#{match_key_column_name} as match_key"
                  select_query = [match_fragment, query_fragment].join(', ')
                  period_result =
                    relation
                      .select(select_query)
                      .group(match_key_column_name)
                      .order(match_key_column_name)
                  periods_results << period_result if period_result.any?
                end

                # create table
                periods_results.each_with_index do |period_results, index|
                  attributes_without_id = period_results[0].attributes.select{|attr| attr != 'id'}
                  query_output << attributes_without_id.keys if index == 0

                  period_results.each do |period_result|
                    attributes_without_id = period_result.attributes.select{|attr| attr != 'id'}
                    attributes_with_parsed_enums = attributes_without_id.map do |key, value|
                      model.defined_enums[key] ? model.defined_enums[key].key(value) : value
                    end
                    query_output << attributes_with_parsed_enums
                  end
                end
              when :dump
                relation.order(:id).each_with_index do |record, index|
                  permitted_attributes = record.attributes.select do |key, value|
                    ALLOWED_MIDDLE_RECORD_MODELS.exclude?(record.class) || !(key =~ /created_at|updated_at|match_key/)
                  end

                  query_output << permitted_attributes.keys if index == 0 # inject header
                  query_output << permitted_attributes.map do |key, value| # inject values
                    model.defined_enums[key] ? model.defined_enums[key].key(value) : value
                  end
                end
              else
                raise StandardError.new("EXPORTER_CONFIG ERROR: Misconfigured type #{type} for mapping #{mapping} for model: #{model}.")
              end

              if destination.fetch(:template)
                # TODO:
                # File operation
                # read template
                # save template with timestamp unless target already exists
                raise StandardError.new('Not implemented')
              else
                # NOTE: Workbook operation
                # create empty workbook
                # save workbook into target unless it already exists
                filename_prefix = destination.fetch(:filename_prefix)
                formatted_timestamp = DateTime.now.strftime("%Y-%m-%d")
                filename = "#{filename_prefix}_#{formatted_timestamp}.xml"
                path = "/public/"
                full_path = "#{Rails.root}#{path}#{filename}"

                unless File.file?(full_path)
                  workbook_namespaces = {
                    'xmlns' => 'urn:schemas-microsoft-com:office:spreadsheet',
                    'xmlns:o' => 'urn:schemas-microsoft-com:office:office',
                    'xmlns:x' => 'urn:schemas-microsoft-com:office:excel',
                    'xmlns:ss' => 'urn:schemas-microsoft-com:office:spreadsheet',
                    'xmlns:html' => 'http://www.w3.org/TR/REC-html40'
                  }

                  builder = Nokogiri::XML::Builder.new do |xml|
                    xml.Workbook(workbook_namespaces)
                  end

                  File.open(full_path, 'a+') do |file|
                    file.write(builder.to_xml)
                  end
                end

                target = File.open(full_path)
              end

              worksheet_name = destination.fetch(:worksheet_name)

              document = Nokogiri::XML(target.read)

              builder_target = document.at('Workbook')

              Nokogiri::XML::Builder.with(builder_target) do |xml|
                xml.Worksheet('ss:Name' => worksheet_name[0..30]) do
                  xml.Table do
                    query_output.each do |query_row|
                      xml.Row do
                        query_row.each do |query_cell|
                          xml.Cell do
                            case query_cell
                            when Integer
                              xml.Data(query_cell, { 'ss:Type' => 'Number'} )
                            when Float
                              xml.Data(query_cell, { 'ss:Type' => 'Number'} )
                            when String
                              xml.Data(query_cell, { 'ss:Type' => 'String'} )
                            when Date, DateTime, ActiveSupport::TimeWithZone
                              xml.Data(query_cell.to_datetime.strftime("%Y-%m-%dT%H:%M:%S.%L"), { 'ss:Type' => 'DateTime'} )
                            when nil, NilClass
                              xml.Data(query_cell, { 'ss:Type' => 'String'} )
                            when TrueClass, FalseClass
                              xml.Data((query_cell ? 1 : 0), { 'ss:Type' => 'Boolean'} )
                            else
                              raise StandardError.new('Not Implemented')
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end

              File.open(full_path, 'w') do |file|
                file.write(document.to_s)
              end
            end
          else
            raise StandardError.new("Destination type: #{destination_type} not implemented.")
          end
        end

        destroy_middle_records()
        puts "Finished export yay :D"
      end

      private

    end
  end
end

