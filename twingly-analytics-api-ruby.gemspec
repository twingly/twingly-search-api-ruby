# encoding: utf-8

require File.expand_path('../lib/twingly-analytics/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = "twingly-analytics-api"
  s.version     = Twingly::Analytics::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Johan Eckerström"]
  s.email       = ["johan.eckerstrom@twingly.com"]
  s.homepage    = "http://github.com/twingly/twingly-analytics-api-ruby"
  s.summary     = "Ruby API client for Twingly Analytics"
  s.description = "Twingly Analytics is a product from Twingly AB"
  s.required_ruby_version = ">= 1.9.3"

  s.add_dependency "nokogiri"
  s.add_development_dependency "rspec"
  s.add_development_dependency "vcr"
  s.add_development_dependency "fakeweb"

  s.files        = Dir.glob("{lib}/**/*") + %w(README.md)
  s.require_path = 'lib'
end
