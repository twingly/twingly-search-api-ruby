require 'nokogiri'

module Twingly
  module Search
    class Parser
      # Parse an API response body.
      #
      # @param [String] document containing an API response XML.
      # @raise [Error] which error depends on the API response (see {Error.from_api_response}).
      # @return [Result] containing the result.
      def parse(document)
        nokogiri = Nokogiri::XML(document)

        failure = nokogiri.at_xpath('/error')
        handle_failure(failure) if failure

        data_node = nokogiri.at_xpath('/twinglydata')
        handle_non_xml_document(document) unless data_node

        create_result(data_node)
      end

      private

      def create_result(data_node)
        result = Result.new
        result.number_of_matches_returned = data_node.attribute('numberOfMatchesReturned').value.to_i
        result.number_of_matches_total    = data_node.attribute('numberOfMatchesTotal').value.to_i
        result.seconds_elapsed            = data_node.attribute('secondsElapsed').value.to_f
        result.incomplete_result          = incomplete_result?(data_node)

        data_node.xpath('//post').each do |post|
          result.posts << parse_post(post)
        end

        result
      end

      def incomplete_result?(data_node)
        data_node.attribute('incompleteResult').value == "true"
      end

      def parse_post(element)
        post_params = {}
        element.element_children.each do |child|
          post_params[child.name] =
            case child.name
            when *%w(tags links images)
              parse_array(child)
            when "coordinates"
              parse_coordinates(child)
            else
              child.text
            end
        end

        post = Post.new
        post.set_values(post_params)
        post
      end

      def parse_array(element)
        element.element_children.map do |child|
          child.text
        end
      end

      def parse_coordinates(element)
        return {} if element.children.empty?

        {
          latitude:  element.at_xpath("latitude").text.to_f,
          longitude: element.at_xpath("longitude").text.to_f,
        }
      end

      def handle_failure(failure)
        code    = failure.attribute('code').value
        message = failure.at_xpath('message').text

        fail Error.from_api_response(code, message)
      end

      def handle_non_xml_document(document)
        fail ServerError, "Failed to parse response: \"#{document}\""
      end

      def parse_time(time)
        Time.parse(time)
      end
    end
  end
end
