module Twingly
  module Search
    class Client
      attr_accessor :api_key

      def initialize(api_key = nil)
        @api_key = api_key || env_api_key || fail("Missing API key")
      end

      def query
        Query.new(self)
      end
    private
      def env_api_key
        ENV['TWINGLY_SEARCH_KEY']
      end
    end
  end
end
