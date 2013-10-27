require 'faraday'

module Twingly
  module Analytics
    class Query
      attr_accessor :pattern, :language, :client
      attr_reader :start_time, :end_time

      BASE_URL = 'http://api.twingly.com'
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

      def start_time=(time)
        @start_time = time.strftime("%F %T")
      end

      def end_time=(time)
        @end_time = time.strftime("%F %T")
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
          :ts => start_time,
          :tsTo => end_time,
          :xmloutputversion => 2
        }
      end

    private

      def get_response
        connection = Faraday.new(:url => BASE_URL) do |faraday|
          faraday.request :url_encoded
          faraday.adapter Faraday.default_adapter
        end
        connection.get(ANALYTICS_PATH, request_parameters)
      end
    end
  end
end
