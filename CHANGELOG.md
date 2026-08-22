# Changelog

## [0.3.4](https://github.com/verified-holidays/verified_holidays/compare/verified_holidays/v0.3.3...verified_holidays/v0.3.4) (2026-08-22)


### Miscellaneous

* drop support for Ruby 3.1 ([#37](https://github.com/verified-holidays/verified_holidays/issues/37)) ([4ee7b8e](https://github.com/verified-holidays/verified_holidays/commit/4ee7b8e45afeb0a6f66306b5044097605e7fc8a5))
* replace deprecated SimpleCov.add_filter with skip ([#36](https://github.com/verified-holidays/verified_holidays/issues/36)) ([51e2234](https://github.com/verified-holidays/verified_holidays/commit/51e223446e74b6290393f0022bab7b55edb9286d))

## [0.3.3](https://github.com/verified-holidays/verified_holidays/compare/verified_holidays/v0.3.2...verified_holidays/v0.3.3) (2026-08-22)


### Bug Fixes

* add English names for holidays present in the dataset ([#32](https://github.com/verified-holidays/verified_holidays/issues/32)) ([1f92812](https://github.com/verified-holidays/verified_holidays/commit/1f92812aea09b9f27d6034556f0576997bdac1db))
* raise FetchError on a non-success Cabinet Office response ([#28](https://github.com/verified-holidays/verified_holidays/issues/28)) ([6d55172](https://github.com/verified-holidays/verified_holidays/commit/6d55172f5eac707e54f5039cf2fbed3ea224af08))
* reject a Cabinet Office response that holds no holidays ([#30](https://github.com/verified-holidays/verified_holidays/issues/30)) ([9040ff5](https://github.com/verified-holidays/verified_holidays/commit/9040ff5f089dcecfdad827f480cac5950663fc99))
* use YAML.dump when writing holidays.yml ([#31](https://github.com/verified-holidays/verified_holidays/issues/31)) ([be2879b](https://github.com/verified-holidays/verified_holidays/commit/be2879b143408af0764057c1e83343f6e9235a9c))


### Miscellaneous

* label docs/ branches from the branch prefix ([#33](https://github.com/verified-holidays/verified_holidays/issues/33)) ([b6867f6](https://github.com/verified-holidays/verified_holidays/commit/b6867f6febe29cfc06d423a4b94a948287437c2e))
* point the tests label at test/ instead of spec/ ([#35](https://github.com/verified-holidays/verified_holidays/issues/35)) ([f86d05b](https://github.com/verified-holidays/verified_holidays/commit/f86d05b29643c5bdb191aef8b17c72a1874b6f39))

## [0.3.2](https://github.com/verified-holidays/verified_holidays/compare/verified_holidays/v0.3.1...verified_holidays/v0.3.2) (2026-08-22)


### Miscellaneous

* write source comments in English ([#26](https://github.com/verified-holidays/verified_holidays/issues/26)) ([aa1879f](https://github.com/verified-holidays/verified_holidays/commit/aa1879f993affaf651f4b8d56277964c617b1f35))

## [0.3.1](https://github.com/verified-holidays/verified_holidays/compare/verified_holidays/v0.3.0...verified_holidays/v0.3.1) (2026-04-28)


### Miscellaneous

* add Ruby 4.0 to test matrix ([#24](https://github.com/verified-holidays/verified_holidays/issues/24)) ([46e0715](https://github.com/verified-holidays/verified_holidays/commit/46e0715ffeb94a3fe973c27b579b39ef3e9406c7))

## [0.3.0](https://github.com/verified-holidays/verified_holidays/compare/verified_holidays-v0.2.2...verified_holidays/v0.3.0) (2026-03-29)


### Features

* auto-publish gem to RubyGems via Trusted Publishers ([#15](https://github.com/verified-holidays/verified_holidays/issues/15)) ([d4b5fd5](https://github.com/verified-holidays/verified_holidays/commit/d4b5fd5c3ea29fb089527ca9c99ca23668b6734b))


### Bug Fixes

* add bundler/gem_tasks to Rakefile for automated gem release ([#17](https://github.com/verified-holidays/verified_holidays/issues/17)) ([3936c18](https://github.com/verified-holidays/verified_holidays/commit/3936c185dc0b1503ad175071a2ed17a8342b692a))
* correct Qlty coverage action parameters and enable OIDC auth ([#22](https://github.com/verified-holidays/verified_holidays/issues/22)) ([54a5368](https://github.com/verified-holidays/verified_holidays/commit/54a53686ac8f2616b3a777c136fa2df74a746c1c))


### Miscellaneous

* add auto-assign workflow for pull requests ([#14](https://github.com/verified-holidays/verified_holidays/issues/14)) ([a09ac2e](https://github.com/verified-holidays/verified_holidays/commit/a09ac2e7b432c56fad6899ba0d32f24a86a91feb))
* harden GitHub Actions workflows and add README badges ([#19](https://github.com/verified-holidays/verified_holidays/issues/19)) ([78cc527](https://github.com/verified-holidays/verified_holidays/commit/78cc527773a50a7b017324c0e07342aaf9a22401))
* introduce release-please for automated releases ([#12](https://github.com/verified-holidays/verified_holidays/issues/12)) ([6690b1b](https://github.com/verified-holidays/verified_holidays/commit/6690b1b355504ca794a950e1b8841b68f4e880fb))
* **main:** release verified_holidays 0.1.5 ([#13](https://github.com/verified-holidays/verified_holidays/issues/13)) ([557c4cc](https://github.com/verified-holidays/verified_holidays/commit/557c4cce459e7128847339b8f6e28e686fc2477c))
* **main:** release verified_holidays 0.2.0 ([#16](https://github.com/verified-holidays/verified_holidays/issues/16)) ([189b13d](https://github.com/verified-holidays/verified_holidays/commit/189b13d65c0c23b460fd377b85fc0f0d484a7582))
* **main:** release verified_holidays 0.2.1 ([#18](https://github.com/verified-holidays/verified_holidays/issues/18)) ([bbbde5c](https://github.com/verified-holidays/verified_holidays/commit/bbbde5ca799fc84c900aff6c2db877fda20eae2d))
* **main:** release verified_holidays 0.2.2 ([#20](https://github.com/verified-holidays/verified_holidays/issues/20)) ([5ff1e67](https://github.com/verified-holidays/verified_holidays/commit/5ff1e673b1ca73f9acd0e3c42ec0090c85680c47))

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
