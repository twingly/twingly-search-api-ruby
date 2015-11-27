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
        matches = "@posts, "
        matches << "@number_of_matches_returned=#{self.number_of_matches_returned}, "
        matches << "@number_of_matches_total=#{self.number_of_matches_total}"

        sprintf("#<%s:0x%x %s>", self.class.name, __id__, matches)
      end
    end
  end
end
