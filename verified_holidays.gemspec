# frozen_string_literal: true

require_relative 'lib/verified_holidays/version'

Gem::Specification.new do |spec|
  spec.name          = 'verified_holidays'
  spec.version       = VerifiedHolidays::VERSION
  spec.authors       = ['Kenta Ishizaki']
  spec.email         = ['kentaishizaki@55728.jp']

  spec.summary       = 'Japanese national holidays with weekly verification against Cabinet Office data'
  spec.description   = 'A Japanese national holiday gem that verifies its built-in data against ' \
                       'the Cabinet Office official CSV every week. ' \
                       'Provides holiday?, between, name, and year methods with English name support.'
  spec.homepage      = 'https://github.com/verified-holidays/verified_holidays'
  spec.license       = 'MIT'

  spec.required_ruby_version = '>= 3.1'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = "#{spec.homepage}/blob/main/CHANGELOG.md"
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.files = Dir.chdir(__dir__) do
    Dir['{lib,data}/**/*', 'LICENSE', 'README.md', 'CHANGELOG.md']
  end
  spec.require_paths = ['lib']

  spec.add_dependency 'csv'
end
