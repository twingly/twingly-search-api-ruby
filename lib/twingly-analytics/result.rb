module Twingly
  module Analytics
    class Result
      attr_accessor :number_of_matches_returned, :number_of_matches_total, :seconds_elapsed

      def posts
        @posts ||= []
      end

      def inspect
        sprintf("#<%s:0x%x %s>", self.class.name, __id__,
          "@posts, @number_of_matches_returned=#{self.number_of_matches_returned}, @number_of_matches_total=#{self.number_of_matches_total}")
      end
    end
  end
end