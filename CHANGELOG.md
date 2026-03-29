# Changelog

## [0.2.2](https://github.com/verified-holidays/verified_holidays/compare/verified_holidays/v0.2.1...verified_holidays/v0.2.2) (2026-03-29)


### Miscellaneous

* harden GitHub Actions workflows and add README badges ([#19](https://github.com/verified-holidays/verified_holidays/issues/19)) ([78cc527](https://github.com/verified-holidays/verified_holidays/commit/78cc527773a50a7b017324c0e07342aaf9a22401))

## [0.2.1](https://github.com/verified-holidays/verified_holidays/compare/verified_holidays/v0.2.0...verified_holidays/v0.2.1) (2026-03-29)


### Bug Fixes

* add bundler/gem_tasks to Rakefile for automated gem release ([#17](https://github.com/verified-holidays/verified_holidays/issues/17)) ([3936c18](https://github.com/verified-holidays/verified_holidays/commit/3936c185dc0b1503ad175071a2ed17a8342b692a))

## [0.2.0](https://github.com/verified-holidays/verified_holidays/compare/verified_holidays/v0.1.5...verified_holidays/v0.2.0) (2026-03-29)


### Features

* auto-publish gem to RubyGems via Trusted Publishers ([#15](https://github.com/verified-holidays/verified_holidays/issues/15)) ([d4b5fd5](https://github.com/verified-holidays/verified_holidays/commit/d4b5fd5c3ea29fb089527ca9c99ca23668b6734b))

## [0.1.5](https://github.com/verified-holidays/verified_holidays/compare/verified_holidays-v0.1.4...verified_holidays/v0.1.5) (2026-03-29)


### Miscellaneous

* add auto-assign workflow for pull requests ([#14](https://github.com/verified-holidays/verified_holidays/issues/14)) ([a09ac2e](https://github.com/verified-holidays/verified_holidays/commit/a09ac2e7b432c56fad6899ba0d32f24a86a91feb))
* introduce release-please for automated releases ([#12](https://github.com/verified-holidays/verified_holidays/issues/12)) ([6690b1b](https://github.com/verified-holidays/verified_holidays/commit/6690b1b355504ca794a950e1b8841b68f4e880fb))

## [0.1.4] - 2026-03-29

- Fix file path labeler removing branch-based labels (sync-labels: false)

## [0.1.3] - 2026-03-29

- Replace numeric index access with header name access in `CabinetOffice.parse`
- Add Auto Release workflow
- Add auto-labeler workflows (file path labeler + branch prefix labeler)

## [0.1.2] - 2026-03-29

- Add SimpleCov with 90% minimum coverage threshold (line and branch)
- Add edge case tests for CSV parsing, Holiday model, Verifier, and main API
- Inline `CabinetOffice.parse_date` using `Date.strptime`
- Add `CabinetOffice.presence` to handle blank CSV fields
- Use `minmax` in `Verifier.filter_local_data`
- Simplify `Dataset#name` to one-liner

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
