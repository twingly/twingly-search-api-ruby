require_relative "profile_helper.rb"

require_relative "../lib/twingly/livefeed"

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
