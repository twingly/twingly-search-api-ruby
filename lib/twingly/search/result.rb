module Twingly
  module Search
    # Represents a result from a {Query} to the Search API
    #
    # @see Query#execute
    # @attr [Integer] number_of_matches_returned number of {Post}s
    #   the {Query} returned.
    # @attr [Integer] number_of_matches_total total number of {Post}s
    #   the {Query} matched.
    # @attr [Integer] seconds_elapsed number of seconds it took to
    #   execute the {Query}.
    class Result
      attr_accessor :number_of_matches_returned, :number_of_matches_total,
        :seconds_elapsed
      attr_writer :incomplete_result

      # @return [true] if one or multiple servers were too slow to respond
      #   within the maximum allowed query time.
      # @return [false] if all servers responded within the maximum allowed
      #   query time.
      # @see https://developer.twingly.com/resources/search/#response
      def incomplete?
        @incomplete_result
      end

      # @return [Array<Post>] all posts that matched the {Query}.
      def posts
        @posts ||= []
      end

      # @return [true] if this result includes all {Post}s that matched the {Query}.
      # @return [false] if there are more {Post}s to fetch from the API.
      def all_results_returned?
        number_of_matches_returned.to_i == number_of_matches_total.to_i
      end

      def inspect
        instance_methods = [
          "posts",
          "number_of_matches_returned=#{self.number_of_matches_returned}",
          "number_of_matches_total=#{self.number_of_matches_total}",
          "seconds_elapsed=#{self.seconds_elapsed}",
          "all_results_returned?=#{self.all_results_returned?}",
          "incomplete?=#{self.incomplete?}",
        ].join(", ")

        sprintf("#<%s:0x%x %s>", self.class.name, __id__, instance_methods)
      end
    end
  end
end
