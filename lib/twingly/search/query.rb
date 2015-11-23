require "faraday"

module Twingly
  module Search
    class Query
      attr_accessor :pattern, :language, :client, :start_time, :end_time

      def initialize(client)
        @client = client
      end

      def url
        "#{client.endpoint_url}?#{url_parameters}"
      end

      def execute
        @client.execute_query(self)
      end

      def url_parameters
        Faraday::Utils.build_query(request_parameters)
      end

      def request_parameters
        fail("Missing pattern") if pattern.to_s.empty?

        {
          key: client.api_key,
          searchpattern: pattern,
          documentlang: language,
          ts: ts,
          tsTo: ts_to,
          xmloutputversion: 2,
        }
      end

      private

      def ts
        start_time.to_time.strftime("%F %T") if start_time
      end

      def ts_to
        end_time.to_time.strftime("%F %T") if end_time
      end
    end
  end
end
