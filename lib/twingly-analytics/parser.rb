require 'nokogiri'

module Twingly
  module Analytics
    class Parser
      def parse(document)
        result = Result.new
        result.posts = Nokogiri::XML(document).xpath('//post').to_a
        result
      end
    end
  end
end