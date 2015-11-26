require "faraday"

module Twingly
  module Search
    class Client
      attr_accessor :api_key, :user_agent

      BASE_URL    = "https://api.twingly.com"
      SEARCH_PATH = "/analytics/Analytics.ashx"

      DEFAULT_USER_AGENT = "Twingly Search Ruby Client/#{VERSION}"

      def initialize(api_key = nil, options = {})
        @api_key = api_key || env_api_key || api_key_missing
        @user_agent = options.fetch(:user_agent) { DEFAULT_USER_AGENT }
      end

      def query
        Query.new(self)
      end

      def execute_query(query)
        response_body = get_response(query).body
        Parser.new.parse(response_body)
      end

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
