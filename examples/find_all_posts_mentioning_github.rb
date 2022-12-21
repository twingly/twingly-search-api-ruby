Bundler.require

class SearchPostStream
  def initialize(keyword, language: nil)
    # Set environment variable TWINGLY_SEARCH_KEY
    client = Twingly::Search::Client.new do |client|
      client.user_agent = "MyCompany/1.0" # Set optional user agent
    end

    @query = client.query do |query|
      query_parts = [
        "sort-order:asc",
        "sort:published",
        keyword,
      ]
      query_parts << "lang:#{language}" if language

      query.search_query = query_parts.join(" ")
    end
  end

  # Run block for each blog post returned from api.
  # Uses a sliding time-based window to get all results.
  # @see https://app.twingly.com/blog_search?tab=documentation
  def each
    loop do
      result = execute_with_retry
      result.posts.each do |post|
        yield post
      end

      break if result.all_results_returned?

      @query.start_time = result.posts.last.published_at
    end
  end

  private

  def execute_with_retry
    Retryable.retryable(on: Twingly::Search::ServerError) do
      @query.execute
    end
  end
end

stream = SearchPostStream.new("(github) AND (hipchat OR slack)")
stream.each do |post|
  puts post.url
end
