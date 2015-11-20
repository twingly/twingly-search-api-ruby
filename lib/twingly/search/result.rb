module Twingly
  module Search
    class Result
      attr_accessor :number_of_matches_returned, :number_of_matches_total,
        :seconds_elapsed

      def posts
        @posts ||= []
      end

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
