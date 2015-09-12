Bundler.require

class AnalyticsPostStream
  def initialize(keyword, language: nil)
    # Set environment variable TWINGLY_ANALYTICS_KEY
    client = Twingly::Analytics::Client.new
    @query = client.query
    @query.language = language
    @query.pattern = "sort-order:asc sort:published #{keyword}"
  end

  def each
    loop do
      result = @query.execute
      result.posts.each do |post|
        yield post
      end

      break if result.all_results_returned?

      @query.start_time = result.posts.last.published
    end
  end
end

stream = AnalyticsPostStream.new("(github) AND (hipchat OR slack)")
stream.each do |post|
  puts post.url
end
