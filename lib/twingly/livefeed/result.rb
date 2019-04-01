module Twingly
  module LiveFeed
    # Represents a result from a request to the LiveFeed API
    #
    # @see Client#next_result
    # @attr [Time] ts the exact time when the result was built
    # @attr [Time] from the timestamp that was sent in the request.
    #   See {Client#timestamp}
    # @attr [Integer] number_of_posts the number of posts this result contains
    # @attr [Integer] max_number_of_posts the maximum number of posts this result
    #   could contain. See {Client#max_posts}
    # @attr [Time] first_post the index time for the first post in the result
    # @attr [Time] last_post the index time for the last post in the result
    # @attr [Time] next_timestamp the timestamp that should be used to get the
    #   next batch of posts
    class Result
      attr_accessor :ts, :from, :number_of_posts, :max_number_of_posts,
        :first_post, :last_post, :next_timestamp

      # @return [Array<Post>] all posts that matched the {Query}.
      def posts
        @posts ||= []
      end

      def inspect
        instance_methods = [
          "posts",
          "ts=#{self.ts}",
          "from=#{self.from}",
          "number_of_posts=#{self.number_of_posts}",
          "max_number_of_posts=#{self.max_number_of_posts}",
          "first_post=#{self.first_post}",
          "last_post=#{self.last_post}",
          "next_timestamp=#{self.next_timestamp}",
        ].join(", ")

        sprintf("#<%s:0x%x %s>", self.class.name, __id__, instance_methods)
      end
    end
  end
end
