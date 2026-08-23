# frozen_string_literal: true

require_relative 'verified_holidays/version'
require_relative 'verified_holidays/holiday'
require_relative 'verified_holidays/dataset'
require_relative 'verified_holidays/cabinet_office'
require_relative 'verified_holidays/verifier'

module VerifiedHolidays
  def self.holiday?(date)
    Dataset.instance.holiday?(date)
  end

  def self.between(start_date, last_date)
    Dataset.instance.between(start_date, last_date)
  end

  def self.name(date)
    Dataset.instance.name(date)
  end

  def self.year(year)
    Dataset.instance.year(year)
  end

  # holiday_jp compatibility: HolidayJp.holidays returns the collection object.
  def self.holidays
    Dataset.instance
  end

  def self.verify!
    Verifier.verify!
  end
end
