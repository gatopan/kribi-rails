module Kribi
  BLACKLISTED_COLUMN_NAMES = [
    'id',
    'match_key',
    'created_at',
    'updated_at',
    'status'
  ]
  PAGINATION_UPPER_LIMIT = 10
  KICK_OFF_DATE = DateTime.new(2015, 12, 26)
  kick_off_year = KICK_OFF_DATE.year

  current_start_of_year = DateTime.new(kick_off_year, 1, 1)

  year_after_kick_off_year = kick_off_year + 1
  next_start_off_year = DateTime.new(year_after_kick_off_year, 1, 1)

  current_start_of_year_offset = Kribi::KICK_OFF_DATE - current_start_of_year
  next_start_off_year_offset = next_start_off_year - Kribi::KICK_OFF_DATE

  CLOSEST_START_OF_YEAR =
    if current_start_of_year_offset > next_start_off_year_offset
      next_start_off_year
    else
      current_start_of_year
    end

  extend ActiveSupport::Autoload

  autoload :Exporter
  autoload :Migration
end
