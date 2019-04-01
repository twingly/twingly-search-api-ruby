require "faraday"
require "time"

module Twingly
  module Search
    # Twingly Search API query
    #
    # @attr [String] search_query the search query.
    # @attr [Client] client the client that this query is connected to.
    class Query
      attr_accessor :search_query, :client

      # @deprecated Please use {#search_query} instead
      def pattern
        warn "[DEPRECATION] `pattern` is deprecated. Please use `search_query` instead."
        @search_query
      end

      # @deprecated Please use {#search_query=} instead
      def pattern=(search_query)
        warn "[DEPRECATION] `pattern=` is deprecated. Please use `search_query=` instead."
        @search_query = search_query
      end

      # @deprecated Please use {#search_query} instead
      def language
        warn "[DEPRECATION] `language` is deprecated. Please use `search_query` instead."
        @language
      end

      # @deprecated Please use {#search_query=} instead
      def language=(language_code)
        warn "[DEPRECATION] `language=` is deprecated. Please use `search_query=` instead."
        @language = language_code
      end

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
        @client     = client
        @start_time = nil
        @end_time   = nil
        @language   = nil

        yield self if block_given?
      end

      # @return [String] the request url for the query.
      def url
        "#{client.endpoint_url}?#{url_parameters}"
      end

      # Executes the query and returns the result.
      #
      # @raise [QueryError] if {#search_query} is empty.
      # @raise [AuthenticationError] if the API couldn't authenticate you. Make sure your API key is correct.
      # @raise [AuthorizationError] if you don't have access to something.
      # @raise [ServerError] if the query could not be executed due to a server error.
      # @return [Result] the result for this query.
      def execute
        @client.execute_query(self)
      end

      # @see #url
      # @return [String] the query part of the request url.
      def url_parameters
        Faraday::Utils.build_query(request_parameters)
      end

      # @raise [QueryError] if {#search_query} is empty.
      # @return [Hash] the request parameters.
      def request_parameters
        full_search_query = search_query.to_s.dup
        full_search_query << " lang:#{@language}" unless @language.to_s.empty?
        full_search_query << " start-date:#{formatted_start_date}" if start_time
        full_search_query << " end-date:#{formatted_end_date}"     if end_time

        if full_search_query.to_s.empty?
          fail QueryError, "Search query cannot be empty"
        end

        {
          apikey: client.api_key,
          q: full_search_query
        }
      end

      # Search for posts published after this time (inclusive).
      #
      # @param [Time, #to_time] time an instance of the Time class
      #   or an object responding to #to_time.
      # @raise [QueryError] if the object cannot be converted to a Time object.
      def start_time=(time)
        assert_valid_time(time)

        @start_time = time
      end

      # Search for posts published before this time (inclusive).
      #
      # @param [Time, #to_time] time an instance of the Time class
      #   or an object responding to #to_time.
      # @raise [QueryError] if the object cannot be converted to a Time object.
      def end_time=(time)
        assert_valid_time(time)

        @end_time = time
      end

      private

      def assert_valid_time(time)
        return if time.nil?

        fail QueryError, "Not a Time object" unless time.respond_to?(:to_time)
      end

      def formatted_start_date
        format_timestamp_for_query(start_time) if start_time
      end

      def formatted_end_date
        format_timestamp_for_query(end_time) if end_time
      end

      def format_timestamp_for_query(timestamp)
        timestamp.to_time.utc.strftime("%FT%T")
      end
    end
  end
end
