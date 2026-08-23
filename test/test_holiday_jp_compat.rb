# frozen_string_literal: true

require 'test_helper'
require 'verified_holidays/holiday_jp_compat'

class TestHolidayJpCompat < Minitest::Test
  def test_holiday_jp_holiday_p
    assert HolidayJp.holiday?(Date.new(2026, 1, 1))
    refute HolidayJp.holiday?(Date.new(2026, 3, 19))
  end

  def test_holiday_jp_between
    holidays = HolidayJp.between(Date.new(2026, 1, 1), Date.new(2026, 1, 31))
    assert holidays.size >= 2
    assert(holidays.all?(HolidayJp::Holiday))
  end

  def test_holiday_jp_holiday_is_verified_holidays_holiday
    assert_equal VerifiedHolidays::Holiday, HolidayJp::Holiday
  end

  def test_holiday_jp_holidays_collection
    holidays = HolidayJp.holidays
    assert holidays.holiday?(Date.new(2026, 1, 1))
    assert_equal 1, holidays.between(Date.new(2026, 1, 1), Date.new(2026, 1, 1)).size
    assert_kind_of Hash, holidays.holidays
    assert_equal '元日', holidays.holidays[Date.new(2026, 1, 1)].name
  end

  def test_holiday_jp_accepts_objects_responding_to_to_date
    date_like = Struct.new(:to_date).new(Date.new(2026, 1, 1))
    assert HolidayJp.holiday?(date_like)
    assert_equal 1, HolidayJp.between(date_like, date_like).size
  end

  def test_holiday_jp_is_verified_holidays
    assert_equal VerifiedHolidays, HolidayJp
  end
end
