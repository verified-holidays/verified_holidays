# VerifiedHolidays

[![Test](https://github.com/verified-holidays/verified_holidays/actions/workflows/test.yml/badge.svg)](https://github.com/verified-holidays/verified_holidays/actions/workflows/test.yml)
[![Weekly Verification](https://github.com/verified-holidays/verified_holidays/actions/workflows/verify.yml/badge.svg)](https://github.com/verified-holidays/verified_holidays/actions/workflows/verify.yml)
[![Gem Version](https://badge.fury.io/rb/verified_holidays.svg)](https://badge.fury.io/rb/verified_holidays)
[![Maintainability](https://qlty.sh/gh/verified-holidays/projects/verified_holidays/maintainability.svg)](https://qlty.sh/gh/verified-holidays/projects/verified_holidays)
[![Coverage](https://qlty.sh/gh/verified-holidays/projects/verified_holidays/coverage.svg)](https://qlty.sh/gh/verified-holidays/projects/verified_holidays)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Japanese national holiday gem with **weekly verification against the Cabinet Office official data**.

If the verification badge is green, the holiday data is correct.

## Why "verified_holidays"?

Because the data is **verified**. Every week, GitHub Actions checks our built-in
holiday data against the Cabinet Office official CSV. If it matches, the badge
stays green.

## Installation

```ruby
gem "verified_holidays"
```

## Usage

```ruby
require "verified_holidays"

# Check if a date is a holiday
VerifiedHolidays.holiday?(Date.new(2026, 1, 1))  # => true
VerifiedHolidays.holiday?(Date.new(2026, 3, 19)) # => false

# Date, DateTime, Time are all accepted
VerifiedHolidays.holiday?(Time.new(2026, 1, 1))  # => true

# Get holidays in a date range
holidays = VerifiedHolidays.between(Date.new(2026, 1, 1), Date.new(2026, 12, 31))
holidays.each do |h|
  puts "#{h.date} #{h.name} (#{h.name_en})"
end

# Get the holiday name
VerifiedHolidays.name(Date.new(2026, 1, 1))  # => "元日"
VerifiedHolidays.name(Date.new(2026, 3, 19)) # => nil

# Get all holidays for a year
VerifiedHolidays.year(2026)
# => [#<VerifiedHolidays::Holiday>, ...]
```

### Holiday object

```ruby
holiday = VerifiedHolidays.between(Date.new(2026, 1, 1), Date.new(2026, 1, 1)).first
holiday.date     # => #<Date: 2026-01-01>
holiday.name     # => "元日"
holiday.name_en  # => "New Year's Day"
holiday.wday_name # => "Thursday"
holiday.week     # => "Thursday" (alias for wday_name)
```

## Migration from holiday_jp

Replace:

```ruby
require "holiday_jp"
```

with:

```ruby
require "verified_holidays/holiday_jp_compat"
```

That's it. `HolidayJp.holiday?`, `HolidayJp.between`, and `HolidayJp::Holiday` all work as before.

## Verification

This gem verifies its built-in data against the [Cabinet Office CSV](https://www8.cao.go.jp/chosei/shukujitsu/syukujitsu.csv) every week via GitHub Actions.

You can also run the verification yourself:

```ruby
result = VerifiedHolidays.verify!
result.valid?      # => true
result.missing     # => entries in local data but not in Cabinet Office CSV
result.extra       # => entries in Cabinet Office CSV but not in local data
result.mismatched  # => entries with different names
```

Or via Rake:

```sh
bundle exec rake verified_holidays:verify
```

## Data Source

Holiday data is sourced from the Cabinet Office of Japan (内閣府):
https://www8.cao.go.jp/chosei/shukujitsu/gaiyou.html

The data is provided under the terms of the [Government of Japan Standard Terms of Use](https://www.kantei.go.jp/jp/singi/it2/densi/kettei/gl2_betten_1.pdf) (CC BY compatible).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/verified-holidays/verified_holidays.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
