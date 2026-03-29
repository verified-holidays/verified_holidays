# frozen_string_literal: true

module VerifiedHolidays
  class Verifier
    class Result
      attr_reader :missing, :extra, :mismatched

      def initialize(missing:, extra:, mismatched:)
        @missing = missing
        @extra = extra
        @mismatched = mismatched
      end

      def valid?
        missing.empty? && extra.empty? && mismatched.empty?
      end
    end

    def self.verify!
      cabinet_data = CabinetOffice.fetch
      local_in_range = filter_local_data(cabinet_data)

      missing, mismatched = compare_local_to_cabinet(local_in_range, cabinet_data)
      extra = find_extra(cabinet_data, local_in_range)

      Result.new(missing: missing, extra: extra, mismatched: mismatched)
    end

    def self.filter_local_data(cabinet_data)
      min_date, max_date = cabinet_data.keys.minmax

      Dataset.instance.all.select { |date, _| date.between?(min_date, max_date) }
    end
    private_class_method :filter_local_data

    def self.compare_local_to_cabinet(local_in_range, cabinet_data)
      missing = []
      mismatched = []

      local_in_range.each do |date, holiday|
        unless cabinet_data.key?(date)
          missing << { date: date, name: holiday.name }
          next
        end

        cabinet_name = cabinet_data[date]
        mismatched << { date: date, expected: holiday.name, actual: cabinet_name } if holiday.name != cabinet_name
      end

      [missing, mismatched]
    end
    private_class_method :compare_local_to_cabinet

    def self.find_extra(cabinet_data, local_in_range)
      cabinet_data.each_with_object([]) do |(date, name), extra|
        extra << { date: date, name: name } unless local_in_range.key?(date)
      end
    end
    private_class_method :find_extra
  end
end
