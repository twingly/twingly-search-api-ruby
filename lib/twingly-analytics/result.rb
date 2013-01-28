module Twingly
  module Analytics
    class Result
      attr_accessor :number_of_documents

      def posts
        @posts ||= []
      end
    end
  end
end