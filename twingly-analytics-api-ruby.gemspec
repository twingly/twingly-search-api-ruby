# encoding: utf-8

lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'twingly-analytics/version'

Gem::Specification.new do |s|
  s.name        = "twingly-analytics-api"
  s.version     = Twingly::Analytics::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Johan Eckerström"]
  s.email       = ["johan.eckerstrom@twingly.com"]
  s.homepage    = "http://github.com/twingly/twingly-analytics-api-ruby"
  s.summary     = "Ruby API client for Twingly Analytics"
  s.description = "Twingly Analytics is a product from Twingly AB"

  s.add_dependency "nokogiri"
  s.add_development_dependency "rspec"

  s.files        = Dir.glob("{lib}/**/*") + %w(README.md)
  s.require_path = 'lib'
end
