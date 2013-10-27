require 'faraday'

module Twingly
  module Analytics
    class Query
      attr_accessor :pattern, :language, :client
      attr_reader :start_time, :end_time

      BASE_URL='http://api.twingly.com/analytics/Analytics.ashx'

      def initialize(client)
        @client = client
      end

      def url
        "#{BASE_URL}?#{url_parameters}"
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

    private

      def get_response
        Faraday.get(url)
      end

      def url_parameters
        fail("Missing pattern") unless pattern

        URI.encode_www_form({
          :key => client.api_key,
          :searchpattern => pattern,
          :documentlang => language,
          :ts => start_time,
          :tsTo => end_time,
          :xmloutputversion => 2
        })
      end
    end
  end
end
