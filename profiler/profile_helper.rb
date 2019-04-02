require "memory_profiler"
require "vcr"

# Prep a fake key
# Only needed when recording new fixtures
ENV["TWINGLY_SEARCH_KEY"] ||= "fake"

VCR.configure do |config|
  config.cassette_library_dir = "profiler/fixtures/vcr_cassettes"
  config.hook_into :webmock
  config.filter_sensitive_data('api_key') { ENV['TWINGLY_SEARCH_KEY'] }
  config.default_cassette_options = {
    match_requests_on: [
      :method,
      VCR.request_matchers.uri_without_param(:timestamp) # Dynamic value
    ]
  }
end
