require 'nokogiri'

module Twingly
  module LiveFeed
    class Parser
      # Parse an API response body.
      #
      # @param [String] document containing an API response XML.
      # @raise [Error] which error depends on the API response (see {Error.from_api_response_message}).
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
        result.ts                  = parse_time(data_node.attribute('ts').value)
        result.from                = parse_time(data_node.attribute('from').value)
        result.number_of_posts     = data_node.attribute('noOfPosts').value.to_i
        result.max_number_of_posts = data_node.attribute('maxNumberOfPosts').value.to_i

        unless result.number_of_posts.zero?
          result.first_post = parse_time(data_node.attribute('firstPost').value)
          result.last_post  = parse_time(data_node.attribute('lastPost').value)
        end

        data_node.xpath('//post').each do |post|
          result.posts << parse_post(post)
        end

        result
      end

      def parse_post(element)
        post_params = {}
        element.element_children.each do |child|
          post_params[child.name] =
            if %w(tags links images).include?(child.name)
              parse_array(child)
            elsif child.name == "coordinates"
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

      # TODO: Decide if a class or hash should be used...
      def parse_coordinates(element)
        return {} if element.children.empty?

        {
          latitude:  element.at_xpath("latitude/text()"),
          longitude: element.at_xpath("longitude/text()"),
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
