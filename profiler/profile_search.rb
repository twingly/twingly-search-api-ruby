require_relative "profile_helper.rb"

require_relative "../lib/twingly/search"

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
