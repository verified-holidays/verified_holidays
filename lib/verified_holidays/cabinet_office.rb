# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'csv'
require 'date'

module VerifiedHolidays
  class CabinetOffice
    CSV_URL = 'https://www8.cao.go.jp/chosei/shukujitsu/syukujitsu.csv'

    def self.fetch
      uri = URI.parse(CSV_URL)
      response = Net::HTTP.get(uri)

      # Remove UTF-8 BOM bytes if present (before encoding conversion)
      raw = response.b
      raw = raw.byteslice(3..) if raw.byteslice(0, 3) == "\xEF\xBB\xBF".b

      # Convert from CP932 (Shift_JIS) to UTF-8
      utf8 = raw.force_encoding('CP932').encode('UTF-8')

      parse(utf8)
    end

    def self.presence(str)
      str&.strip&.then { |s| s unless s.empty? }
    end
    private_class_method :presence

    def self.parse(csv_string)
      holidays = {}
      CSV.parse(csv_string, headers: true) do |row|
        date_str = presence(row['国民の祝日・休日月日'])
        name = presence(row['国民の祝日・休日名称'])
        next if date_str.nil? || name.nil?

        holidays[Date.strptime(date_str, '%Y/%m/%d')] = name
      end
      holidays
    end
  end
end
