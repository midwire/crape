if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start do
    add_filter "spec/"
    add_filter "vendor/"
  end
end

require "pry"
require File.join(File.dirname(__FILE__), '..', 'lib', 'crape')

PROJECT_ROOT = File.expand_path('..', File.dirname(__FILE__))

RSpec.configure do |config|
  config.mock_with :rspec
  config.color_enabled = true
end
