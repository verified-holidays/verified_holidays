# frozen_string_literal: true

require 'test_helper'

class TestVerifiedHolidays < Minitest::Test
  def test_between
    holidays = VerifiedHolidays.between(Date.new(2015, 9, 1), Date.new(2015, 9, 30))
    names = holidays.map(&:name)
    assert_includes names, '敬老の日'
    assert_includes names, '秋分の日'
    assert_includes names, '休日'
  end

  def test_between_accepts_datetime
    holidays = VerifiedHolidays.between(DateTime.new(2015, 9, 1), DateTime.new(2015, 9, 30))
    names = holidays.map(&:name)
    assert_includes names, '敬老の日'
  end

  def test_between_accepts_time
    holidays = VerifiedHolidays.between(Time.new(2015, 9, 1), Time.new(2015, 9, 30))
    names = holidays.map(&:name)
    assert_includes names, '敬老の日'
  end

  def test_holiday_p
    assert VerifiedHolidays.holiday?(Date.new(2026, 1, 1))
    refute VerifiedHolidays.holiday?(Date.new(2026, 3, 19))
  end

  def test_holiday_p_accepts_datetime
    assert VerifiedHolidays.holiday?(DateTime.new(2026, 1, 1))
  end

  def test_holiday_p_accepts_time
    assert VerifiedHolidays.holiday?(Time.new(2026, 1, 1))
  end

  def test_mountain_day_from_2016
    refute VerifiedHolidays.holiday?(Date.new(2015, 8, 11))
    assert VerifiedHolidays.holiday?(Date.new(2016, 8, 11))
    assert_equal '山の日', VerifiedHolidays.name(Date.new(2016, 8, 11))
  end

  def test_emperors_birthday
    # Showa Emperor's Birthday (April 29) until 1988
    assert_equal '天皇誕生日', VerifiedHolidays.name(Date.new(1988, 4, 29))

    # Heisei Emperor's Birthday (December 23)
    assert_equal '天皇誕生日', VerifiedHolidays.name(Date.new(2018, 12, 23))

    # No Emperor's Birthday on Dec 23 in 2019
    refute_equal '天皇誕生日', VerifiedHolidays.name(Date.new(2019, 12, 23))

    # Reiwa Emperor's Birthday (February 23) from 2020
    assert_equal '天皇誕生日', VerifiedHolidays.name(Date.new(2020, 2, 23))
  end

  def test_emperors_enthronement_2019
    # Enthronement Day - May 1, 2019
    assert VerifiedHolidays.holiday?(Date.new(2019, 5, 1))

    # Enthronement Ceremony - October 22, 2019
    assert VerifiedHolidays.holiday?(Date.new(2019, 10, 22))
  end

  def test_name
    assert_equal '元日', VerifiedHolidays.name(Date.new(2026, 1, 1))
    assert_nil VerifiedHolidays.name(Date.new(2026, 3, 19))
  end

  def test_year
    holidays = VerifiedHolidays.year(2026)
    assert_kind_of Array, holidays
    assert holidays.size > 10
    assert(holidays.all?(VerifiedHolidays::Holiday))
    assert(holidays.all? { |h| h.date.year == 2026 })
  end

  def test_year_returns_empty_for_unknown_year
    holidays = VerifiedHolidays.year(1800)
    assert_equal [], holidays
  end

  def test_between_single_day_range
    holidays = VerifiedHolidays.between(Date.new(2026, 1, 1), Date.new(2026, 1, 1))
    assert_equal 1, holidays.size
    assert_equal Date.new(2026, 1, 1), holidays.first.date
  end

  def test_holiday_p_raises_for_invalid_type
    assert_raises(ArgumentError) { VerifiedHolidays.holiday?('2026-01-01') }
  end

  def test_between_raises_for_invalid_type
    assert_raises(ArgumentError) { VerifiedHolidays.between('2026-01-01', '2026-01-31') }
  end

  def test_name_raises_for_invalid_type
    assert_raises(ArgumentError) { VerifiedHolidays.name('2026-01-01') }
  end
end
