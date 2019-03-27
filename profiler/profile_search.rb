require "memory_profiler"
require "vcr"

require_relative "../lib/twingly/search"

# Prep a fake key
# Only needed when recording new fixtures
ENV["TWINGLY_SEARCH_KEY"] ||= "fake"

VCR.configure do |config|
  config.cassette_library_dir = "profiler/fixtures/vcr_cassettes"
  config.hook_into :webmock
  config.filter_sensitive_data('api_key') { ENV['TWINGLY_SEARCH_KEY'] }
end

report_options = {
  allow_files: /twingly/ # Ignore gems
}

report = MemoryProfiler.report(report_options) do
  VCR.use_cassette("blog_search_100") do
    client = Twingly::Search::Client.new do |client|
      client.user_agent = "MyCompany/1.0"
    end

    query = client.query do |query|
      query.search_query  = "github page-size:100"
    end

    query.execute
  end
end

report.pretty_print
