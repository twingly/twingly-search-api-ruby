require "faraday"
require "time"

module Twingly
  module LiveFeed
    # Twingly LiveFeed API client
    #
    # @attr [String] api_key the API key
    # @attr [String] user_agent the user agent to be used for all API requests
    # @attr [Integer] max_posts the maximum number of posts that each request can return
    # @attr [Time] timestamp the timestamp that will be used in the next request
    class Client
      attr_accessor :api_key, :user_agent, :max_posts, :timestamp

      BASE_URL             = "https://api.twingly.com"
      LIVEFEED_API_VERSION = "v5"
      LIVEFEED_PATH        = "/blog/livefeed/api/#{LIVEFEED_API_VERSION}/getdata"

      DEFAULT_USER_AGENT = "Twingly LiveFeed Ruby Client/#{VERSION}"
      DEFAULT_MAX_POSTS  = 1000
      TIMESTAMP_FORMAT   = "%Y-%m-%dT%H:%M:%S.%3N%z"

      # Creates a new Twingly Search API client
      #
      # @param api_key [String] the API key provided by Twingly.
      #   If nil, reads key from environment (TWINGLY_SEARCH_KEY).
      # @param options [Hash]
      # @option options [String] :user_agent the user agent to be used
      #    for all requests
      # @option options [String] :max_posts the maximum number of posts that can
      #    be returned for each request
      # @option options [String] :timestamp the timestamp to start the client at
      # @raise [AuthError] if an API key is not set
      def initialize(api_key = nil, options = {})
        @api_key    = api_key
        @user_agent = options.fetch(:user_agent) { DEFAULT_USER_AGENT }
        @max_posts  = options.fetch(:max_posts)  { DEFAULT_MAX_POSTS }
        @timestamp  = options.fetch(:timestamp)  { Time.now }

        yield self if block_given?

        @api_key ||= env_api_key || api_key_missing
      end

      # Get the next result from the API and updates the next timestamp
      #
      # Sends a request to the API using the timestamp set with {#timestamp},
      # updates the timestamp that should be used in the next request and
      # then returns the result.
      #
      # @raise [QueryError] if the timestamp is invalid.
      # @raise [AuthError] if the API couldn't authenticate you. Make sure your API key is correct.
      # @raise [ServerError] if the query could not be executed due to a server error.
      # @return [Result] the result for this request.
      def next_result
        assert_valid_time(timestamp)

        get_and_parse_result.tap do |result|
          update_timestamp(result.next_timestamp)
        end
      end

      # @return [String] the request url for the next request.
      def url
        "#{endpoint_url}?#{url_parameters}"
      end

      # @return [String] the API endpoint URL.
      def endpoint_url
        "#{BASE_URL}#{LIVEFEED_PATH}"
      end

      # @see #url
      # @return [String] the query part of the request url.
      def url_parameters
        Faraday::Utils.build_query(request_parameters)
      end

      # @return [Hash] the request parameters.
      def request_parameters
        {
          apikey:    api_key,
          timestamp: timestamp.to_time.utc.strftime(TIMESTAMP_FORMAT),
          maxPosts:  max_posts,
        }
      end

      private

      def update_timestamp(timestamp)
        @timestamp = timestamp
      end

      def get_and_parse_result
        response_body = get_response.body
        Parser.new.parse(response_body)
      end

      def get_response
        connection = Faraday.new(url: BASE_URL) do |faraday|
          faraday.request :url_encoded
          faraday.adapter Faraday.default_adapter
        end
        connection.headers[:user_agent] = user_agent
        connection.get(LIVEFEED_PATH, request_parameters)
      end

      def env_api_key
        ENV['TWINGLY_SEARCH_KEY']
      end

      def api_key_missing
        fail AuthError, "No API key has been provided."
      end

      def assert_valid_time(time)
        fail QueryError, "Not a Time object" unless time.respond_to?(:to_time)
      end
    end
  end
end
