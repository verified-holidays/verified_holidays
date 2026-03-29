# frozen_string_literal: true

require 'singleton'
require 'yaml'
require 'date'

module VerifiedHolidays
  class Dataset
    include Singleton

    def initialize
      @holidays = load_yaml
    end

    def all
      @holidays
    end

    def between(start_date, last_date)
      start_date = to_date(start_date)
      last_date = to_date(last_date)
      @holidays.each_with_object([]) do |(date, holiday), result|
        result << holiday if date.between?(start_date, last_date)
      end
    end

    def holiday?(date)
      @holidays.key?(to_date(date))
    end

    def name(date)
      @holidays[to_date(date)]&.name
    end

    def year(year)
      @holidays.each_with_object([]) do |(date, holiday), result|
        result << holiday if date.year == year
      end
    end

    private

    def to_date(value)
      # DateTime は Date のサブクラスだが、明示的に .to_date で Date に変換
      return value.to_date if value.is_a?(DateTime) || value.is_a?(Time)
      return value if value.is_a?(Date)

      raise ArgumentError, "expected Date, DateTime, or Time, got #{value.class}"
    end

    def load_yaml
      path = File.expand_path('../../data/holidays.yml', __dir__)
      data = YAML.safe_load_file(path, permitted_classes: [Date])
      result = {}
      data.each do |date, name|
        date = Date.parse(date.to_s) unless date.is_a?(Date)
        result[date] = Holiday.new(date, name)
      end
      result
    end
  end
end
