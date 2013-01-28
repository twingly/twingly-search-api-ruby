require 'nokogiri'

module Twingly
  module Analytics
    class Parser
      def parse(document)
        result = Result.new
        nokogiri = Nokogiri::XML(document)
        nokogiri.xpath('//post').each do |post|
          result.posts << parse_post(post)
        end
        result.number_of_documents = nokogiri.at_xpath('/TermSearch/@numberOfDocuments').value.to_i
        result
      end
    private
      def parse_post(element)
        post = {}
        element.element_children.each do |child|
          post[child.name] = child.text
        end
        Post.new(post)
      end
    end
  end
end