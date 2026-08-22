# frozen_string_literal: true

module VerifiedHolidays
  class Holiday
    WDAY_NAMES = %w[日 月 火 水 木 金 土].freeze

    EN_HOLIDAY_NAMES = {
      '元日' => "New Year's Day",
      '成人の日' => 'Coming of Age Day',
      '建国記念の日' => 'National Foundation Day',
      '天皇誕生日' => "Emperor's Birthday",
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
      '振替休日' => 'Substitute Holiday',
      '休日' => "Citizens' Holiday",
      '休日（祝日扱い）' => 'Public Holiday',
      '体育の日' => 'Health and Sports Day',
      '体育の日（スポーツの日）' => 'Health and Sports Day (Sports Day)',
      '国民の休日' => "Citizens' Holiday",
      '即位礼正殿の儀' => 'Enthronement Ceremony',
      '即位礼正殿の儀の行われる日' => 'Enthronement Ceremony',
      '即位の日' => 'Enthronement Day',
      '天皇の即位の日及び即位礼正殿の儀の行われる日を休日とする法律' => 'Holiday by Law',
      'みどりの日（国民の休日）' => "Greenery Day (Citizens' Holiday)",
      '結婚の儀' => 'Imperial Wedding Ceremony',
      '大喪の礼' => 'Imperial Funeral Ceremony',
    }.freeze

    attr_reader :date, :name

    def initialize(date, name)
      @date = date
      @name = name
    end

    def name_en
      EN_HOLIDAY_NAMES[name]
    end

    def wday_name
      WDAY_NAMES[date.wday]
    end

    alias week wday_name
  end
end
