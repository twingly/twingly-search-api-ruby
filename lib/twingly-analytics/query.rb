require 'faraday'

module Twingly
  module Analytics
    class Query
      attr_accessor :pattern, :language, :client, :start_time, :end_time

      BASE_URL = 'https://api.twingly.com'
      ANALYTICS_PATH = '/analytics/Analytics.ashx'

      def initialize(client)
        @client = client
      end

      def url
        "#{BASE_URL}#{ANALYTICS_PATH}?#{url_parameters}"
      end

      def execute
        Parser.new.parse(get_response.body)
      end

      def url_parameters
        Faraday::Utils.build_query(request_parameters)
      end

      def request_parameters
        fail("Missing pattern") unless pattern

        {
          :key => client.api_key,
          :searchpattern => pattern,
          :documentlang => language,
          :ts => ts,
          :tsTo => ts_to,
          :xmloutputversion => 2
        }
      end

    private

      def ts
        start_time.to_time.strftime("%F %T") if start_time
      end

      def ts_to
        end_time.to_time.strftime("%F %T") if end_time
      end

      def get_response
        connection = Faraday.new(:url => BASE_URL) do |faraday|
          faraday.request :url_encoded
          faraday.adapter Faraday.default_adapter
        end
        connection.headers[:user_agent] = "Twingly Analytics Ruby Client/#{VERSION}"
        connection.get(ANALYTICS_PATH, request_parameters)
      end
    end
  end
end
