require "faraday"

module Twingly
  module Search
    class Client
      attr_accessor :api_key

      BASE_URL    = "https://api.twingly.com"
      SEARCH_PATH = "/analytics/Analytics.ashx"

      def initialize(api_key = nil)
        @api_key = api_key || env_api_key || fail("Missing API key")
      end

      def query
        Query.new(self)
      end

      def execute_query(query)
        response_body = get_response(query).body
        Parser.new.parse(response_body)
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
        connection.headers[:user_agent] = "Twingly Search Ruby Client/#{VERSION}"
        connection.get(SEARCH_PATH, query.request_parameters)
      end
    end
  end
end
