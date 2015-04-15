# encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'twingly-analytics/version'

Gem::Specification.new do |spec|
  spec.name          = "twingly-analytics"
  spec.version       = Twingly::Analytics::VERSION
  spec.platform      = Gem::Platform::RUBY
  spec.authors       = ["Johan Eckerström"]
  spec.email         = ["johan.eckerstrom@twingly.com"]
  spec.homepage      = "http://github.com/twingly/twingly-analytics-api-ruby"
  spec.summary       = "Ruby API client for Twingly Analytics"
  spec.description   = "Twingly Analytics is a product from Twingly AB"
  spec.license       = 'MIT'
  spec.required_ruby_version = ">= 1.9.3"

  spec.files         = `git ls-files`.split($/)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday",  ['>= 0.8', '< 0.10']
  spec.add_dependency "nokogiri", "~> 1.0"
  spec.add_development_dependency "rspec", "~> 3"
  spec.add_development_dependency "rspec-its", "~> 1"
  spec.add_development_dependency "vcr", "~> 2.6"
  spec.add_development_dependency "webmock", "~> 1.0"
  spec.add_development_dependency "rake"
end
