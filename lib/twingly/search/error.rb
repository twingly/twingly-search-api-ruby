module Twingly
  module Search
    class Error < StandardError
      # @param [String] message API response error message
      # @return [Error] an instance of an {AuthError} or {ServerError},
      #   which one depends on the message.
      def self.from_api_response_message(message)
        error =
          if message =~ /API key/
            AuthError
          else
            ServerError
          end

        error.new(message)
      end
    end

    class AuthError < Error
    end

    class ServerError < Error
    end

    class MissingPatternError < Error
      def initialize
        super("Missing pattern")
      end
    end
  end
end
