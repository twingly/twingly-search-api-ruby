require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :fakeweb
  c.filter_sensitive_data('api_key') { ENV['TWINGLY_ANALYTICS_KEY'] }
end