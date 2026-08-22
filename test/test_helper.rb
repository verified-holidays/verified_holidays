# frozen_string_literal: true

require 'simplecov'
SimpleCov.start do
  enable_coverage :branch
  skip '/test/'
  minimum_coverage line: 90, branch: 90
end

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'verified_holidays'
require 'minitest/autorun'
