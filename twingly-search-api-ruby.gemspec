# encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'twingly/search/version'

Gem::Specification.new do |spec|
  spec.name          = "twingly-search"
  spec.version       = Twingly::Search::VERSION
  spec.platform      = Gem::Platform::RUBY
  spec.authors       = ["Twingly AB"]
  spec.email         = ["support@twingly.com"]
  spec.homepage      = "https://github.com/twingly/twingly-search-api-ruby"
  spec.summary       = "Ruby API client for Twingly Search"
  spec.description   = "Twingly Search is a product from Twingly AB"
  spec.license       = 'MIT'
  spec.required_ruby_version = ">= 2.5.0"

  spec.files         = `git ls-files`.split($/)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday",  [">= 0.9.2", "< 2.0"]
  spec.add_dependency "nokogiri", "~> 1.0"
  spec.add_development_dependency "rspec", "~> 3"
  spec.add_development_dependency "rspec-its", "~> 1"
  spec.add_development_dependency "vcr", "~> 6.0"
  spec.add_development_dependency "webmock", "~> 3.4"
  spec.add_development_dependency "rake", "~> 12"
  spec.add_development_dependency "yard", [">= 0.9.11", "< 1.0.0"]
  spec.add_development_dependency "memory_profiler", "~> 0.9"
  spec.add_development_dependency "rubocop", "~> 0.66.0"
end
