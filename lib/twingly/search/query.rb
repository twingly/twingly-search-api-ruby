require "faraday"

module Twingly
  module Search
    # Twingly Search API query
    #
    # @attr [String] pattern the search query.
    # @attr [String] language which language to restrict the query to.
    # @attr [Client] client the client that this query is connected to.
    # @attr [Time, #to_time] start_time search for posts published after
    #   this time (inclusive).
    # @attr [Time, #to_time] end_time search for posts published before
    #   this time (inclusive).
    class Query
      attr_accessor :pattern, :language, :client, :start_time, :end_time

      # No need to call this method manually, instead use {Client#query}.
      #
      # @param client [Client] the client that this query should be connected to.
      def initialize(client)
        @client = client
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
