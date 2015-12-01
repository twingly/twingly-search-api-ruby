require "faraday"

module Twingly
  module Search
    # Twingly Search API client
    class Client
      attr_accessor :api_key, :user_agent

      BASE_URL    = "https://api.twingly.com"
      SEARCH_PATH = "/analytics/Analytics.ashx"

      DEFAULT_USER_AGENT = "Twingly Search Ruby Client/#{VERSION}"

      # Creates a new Twingly Search API client
      #
      # @param api_key [optional, String] the API key provided by Twingly.
      #   If nil, reads api_key from environment (TWINGLY_SEARCH_KEY).
      # @param options [Hash]
      # @option options [String] :user_agent the user agent to be used
      #    for all requests
      # @raise [AuthError] if an API key is not set.
      def initialize(api_key = nil, options = {})
        @api_key    = api_key
        @user_agent = options.fetch(:user_agent) { DEFAULT_USER_AGENT }

        yield self if block_given?

        @api_key ||= env_api_key || api_key_missing
      end

      # Returns a new Query object connected to this client
      #
      # @yield [Query]
      # @return [Query]
      def query(&block)
        Query.new(self, &block)
      end

      # Executes the given Query and returns the result
      #
      # This method should not be called manually, as that is
      # handled by {Query#execute}.
      #
      # @param query [Query] the query to be executed.
      # @return [Result]
      def execute_query(query)
        response_body = get_response(query).body
        Parser.new.parse(response_body)
      end

      # @return [String] the API endpoint URL
      def endpoint_url
        "#{BASE_URL}#{SEARCH_PATH}"
      end

      private

      def env_api_key
        ENV['TWINGLY_SEARCH_KEY']
      end

      def get_response(query)
        connection = Faraday.new(url: BASE_URL) do |faraday|
          faraday.request :url_encoded
          faraday.adapter Faraday.default_adapter
        end
        connection.headers[:user_agent] = user_agent
        connection.get(SEARCH_PATH, query.request_parameters)
      end

      def api_key_missing
        fail AuthError, "No API key has been provided."
      end
    end
  end
end
