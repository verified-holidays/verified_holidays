# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rake/testtask'
require 'rubocop/rake_task'

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.test_files = FileList['test/**/test_*.rb']
end

RuboCop::RakeTask.new

task default: %i[test rubocop]

namespace :verified_holidays do
  desc 'Verify holidays against Cabinet Office CSV'
  task :verify do
    require 'verified_holidays'
    result = VerifiedHolidays.verify!
    if result.valid?
      puts 'All holidays verified successfully!'
      next
    end

    puts 'Verification FAILED!'
    result.missing.each { |e| puts "  MISSING: #{e[:date]} #{e[:name]}" }
    result.extra.each { |e| puts "  EXTRA:   #{e[:date]} #{e[:name]}" }
    result.mismatched.each { |e| puts "  MISMATCH: #{e[:date]} expected=#{e[:expected]} actual=#{e[:actual]}" }
    abort
  end

  desc 'Update local holidays.yml from Cabinet Office CSV'
  task :update do
    require 'verified_holidays/cabinet_office'
    holidays = VerifiedHolidays::CabinetOffice.fetch
    path = File.expand_path('data/holidays.yml', __dir__)
    File.open(path, 'w') do |f|
      f.puts '---'
      holidays.sort_by { |date, _| date }.each do |date, name|
        f.puts "#{date}: #{name}"
      end
    end
    puts "Updated #{path} with #{holidays.size} holidays"
  end
end
