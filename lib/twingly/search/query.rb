require "faraday"
require "time"

module Twingly
  module Search
    # Twingly Search API query
    #
    # @attr [String] pattern the search query.
    # @attr [String] language language to restrict the query to.
    # @attr [Client] client the client that this query is connected to.
    class Query
      attr_accessor :pattern, :language, :client

      # @return [Time] the time that was set with {#start_time=}.
      def start_time
        @start_time
      end

      # @return [Time] the time that was set with {#end_time=}.
      def end_time
        @end_time
      end

      # No need to call this method manually, instead use {Client#query}.
      #
      # @param client [Client] the client that this query should be connected to.
      def initialize(client)
        @client = client
        yield self if block_given?
      end

      # @return [String] the request url for the query.
      def url
        "#{client.endpoint_url}?#{url_parameters}"
      end

      # Executes the query and returns the result.
      #
      # @raise [QueryError] if {#pattern} is empty.
      # @return [Result] the result for this query.
      def execute
        @client.execute_query(self)
      end

      # @see #url
      # @return [String] the query part of the request url.
      def url_parameters
        Faraday::Utils.build_query(request_parameters)
      end

      # @raise [QueryError] if {#pattern} is empty.
      # @return [Hash] the request parameters.
      def request_parameters
        fail QueryError, "Missing pattern" if pattern.to_s.empty?

        {
          key: client.api_key,
          searchpattern: pattern,
          documentlang: language,
          ts: ts,
          tsTo: ts_to,
          xmloutputversion: 2,
        }
      end

      # Search for posts published after this time (inclusive).
      #
      # @param [Time, #to_time] time an instance of the Time class
      #   or an object responding to #to_time.
      def start_time=(time)
        assert_valid_time(time)

        @start_time = time
      end

      # Search for posts published before this time (inclusive).
      #
      # @param [Time, #to_time] time an instance of the Time class
      #   or an object responding to #to_time.
      def end_time=(time)
        assert_valid_time(time)

        @end_time = time
      end

      private

      def assert_valid_time(time)
        return if time.nil?

        fail QueryError, "Not a Time object" unless time.respond_to?(:to_time)
      end

      def ts
        start_time.to_time.utc.strftime("%F %T") if start_time
      end

      def ts_to
        end_time.to_time.utc.strftime("%F %T") if end_time
      end
    end
  end
end
