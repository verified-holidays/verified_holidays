# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'csv'
require 'date'

module VerifiedHolidays
  class CabinetOffice
    CSV_URL = 'https://www8.cao.go.jp/chosei/shukujitsu/syukujitsu.csv'

    # Raised when the Cabinet Office CSV cannot be retrieved.
    class FetchError < StandardError; end

    def self.fetch
      holidays = parse(download_csv)
      raise FetchError, "#{CSV_URL} returned no holidays" if holidays.empty?

      holidays
    end

    def self.download_csv
      response = Net::HTTP.get_response(URI.parse(CSV_URL))
      unless response.is_a?(Net::HTTPSuccess)
        raise FetchError, "Failed to fetch #{CSV_URL}: HTTP #{response.code} #{response.message}"
      end

      # Remove UTF-8 BOM bytes if present (before encoding conversion)
      raw = response.body.b
      raw = raw.byteslice(3..) if raw.byteslice(0, 3) == "\xEF\xBB\xBF".b

      # Convert from CP932 (Shift_JIS) to UTF-8
      raw.force_encoding('CP932').encode('UTF-8')
    end
    private_class_method :download_csv

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
    rescue Date::Error => e
      raise FetchError, "#{CSV_URL} contains an invalid date: #{e.message}"
    end
  end
end
