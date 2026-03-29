# frozen_string_literal: true

require 'test_helper'

class TestHoliday < Minitest::Test
  def setup
    @holiday = VerifiedHolidays::Holiday.new(Date.new(2026, 1, 1), '元日')
  end

  def test_date
    assert_equal Date.new(2026, 1, 1), @holiday.date
  end

  def test_name
    assert_equal '元日', @holiday.name
  end

  def test_name_en
    assert_equal "New Year's Day", @holiday.name_en
  end

  def test_wday_name
    assert_equal '木', @holiday.wday_name
  end

  def test_week_alias
    assert_equal @holiday.wday_name, @holiday.week
  end

  EN_HOLIDAY_TEST_DATA = {
    '成人の日' => 'Coming of Age Day',
    '建国記念の日' => 'National Foundation Day',
    '春分の日' => 'Vernal Equinox Day',
    '昭和の日' => 'Showa Day',
    '憲法記念日' => 'Constitution Memorial Day',
    'みどりの日' => 'Greenery Day',
    'こどもの日' => "Children's Day",
    '海の日' => 'Marine Day',
    '山の日' => 'Mountain Day',
    '敬老の日' => 'Respect for the Aged Day',
    '秋分の日' => 'Autumnal Equinox Day',
    'スポーツの日' => 'Sports Day',
    '文化の日' => 'Culture Day',
    '勤労感謝の日' => 'Labor Thanksgiving Day',
    '天皇誕生日' => "Emperor's Birthday",
    '振替休日' => 'Substitute Holiday',
    '休日' => "Citizens' Holiday",
  }.freeze

  def test_name_en_for_various_holidays
    EN_HOLIDAY_TEST_DATA.each do |ja, en|
      h = VerifiedHolidays::Holiday.new(Date.new(2026, 1, 1), ja)
      assert_equal en, h.name_en, "Expected #{en} for #{ja}"
    end
  end

  def test_name_en_returns_nil_for_unknown
    h = VerifiedHolidays::Holiday.new(Date.new(2026, 1, 1), '不明な祝日')
    assert_nil h.name_en
  end
end
