require "memory_profiler"
require "vcr"

require_relative "../lib/twingly/livefeed"

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
      VCR.request_matchers.uri_without_param(:timestamp)
    ]
  }
end

report_options = {
  allow_files: /twingly/ # Ignore gems
}

report = MemoryProfiler.report(report_options) do
  VCR.use_cassette("blog_livefeed_100") do
    client = Twingly::LiveFeed::Client.new do |client|
      client.user_agent = "MyCompany/1.0"
      client.timestamp = Time.now - 3600
      client.max_posts = 100
    end

    result = client.next_result
  end
end

report.pretty_print
