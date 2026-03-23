# Changelog

## [0.1.1] - 2026-03-23

- Move repository to GitHub Organization: `verified-holidays/verified_holidays`
- Update all repository URLs in gemspec, README badges, and contributing link

## [0.1.0] - 2026-03-20

- Initial release as `verified_holidays` (previously developed as `shukujitsu`)
- `VerifiedHolidays.holiday?` — check if a date is a Japanese national holiday
- `VerifiedHolidays.between` — list holidays in a date range
- `VerifiedHolidays.name` — get the holiday name for a date
- `VerifiedHolidays.year` — list all holidays for a given year
- `VerifiedHolidays.verify!` — verify built-in data against Cabinet Office CSV
- `VerifiedHolidays::Holiday` — holiday data class with `name_en`, `wday_name`
- holiday_jp drop-in compatibility via `require 'verified_holidays/holiday_jp_compat'`
- Weekly CI verification against Cabinet Office official data
- Holiday data from 1955 to 2027 (sourced from Cabinet Office CSV)
