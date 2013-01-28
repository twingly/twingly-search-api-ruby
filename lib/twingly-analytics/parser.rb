require 'nokogiri'

module Twingly
  module Analytics
    class Parser
      def parse(document)
        result = Result.new
        Nokogiri::XML(document).xpath('//post').each do |post|
          result.posts << parse_post(post)
        end
        result
      end
    private
      def parse_post(element)
        post = {}
        element.element_children.each do |child|
          post[child.name] = child.text
        end
        post
      end
    end
  end
end