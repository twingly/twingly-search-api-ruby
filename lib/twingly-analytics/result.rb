require 'nokogiri'

module Twingly
  module Analytics
    class Result
      def initialize(response_body = nil)
        @document = Nokogiri::XML(response_body)
      end

      def posts
        @document.xpath('//post').to_a
      end
    end
  end
end