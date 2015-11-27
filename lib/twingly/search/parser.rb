require 'nokogiri'

module Twingly
  module Search
    class Parser
      # Parse an API response body.
      #
      # @param [String] document containing an API response XML.
      # @raise [Error] which error depends on the API response (see {Error.from_api_response_message}).
      # @return [Result] containing the result for this.
      def parse(document)
        nokogiri = Nokogiri::XML(document)

        failure = nokogiri.at_xpath('//name:blogstream/name:operationResult[@resultType="failure"]', name: 'http://www.twingly.com')
        handle_failure(failure) if failure

        result = Result.new
        result.number_of_matches_returned = nokogiri.at_xpath('/twinglydata/@numberOfMatchesReturned').value.to_i
        result.number_of_matches_total = nokogiri.at_xpath('/twinglydata/@numberOfMatchesTotal').value.to_i
        result.seconds_elapsed = nokogiri.at_xpath('/twinglydata/@secondsElapsed').value.to_f

        nokogiri.xpath('//post').each do |post|
          result.posts << parse_post(post)
        end

        result
      end

      private

      def parse_post(element)
        post_params = {}
        element.element_children.each do |child|
          if child.name == 'tags'
            post_params[child.name] = parse_tags(child)
          else
            post_params[child.name] = child.text
          end
        end
        post = Post.new
        post.set_values(post_params)
        post
      end

      def parse_tags(element)
        element.element_children.map do |child|
          child.text
        end
      end

      def handle_failure(failure)
        fail Error.from_api_response_message(failure.text)
      end
    end
  end
end
