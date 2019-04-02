module Twingly
  module Search
    class Error < StandardError
      def self.from_api_response(code, message)
        error =
          case code.to_s
          when /^400/, /^404/
            QueryError
          when /^401/ # E.g. API key not enabled
            AuthenticationError
          when /^402/ # E.g. language access denied
            AuthorizationError
          else
            ServerError
          end

        error.new("#{message} (code: #{code})")
      end
    end

    class AuthError < Error
    end

    class AuthenticationError < AuthError
    end

    class AuthorizationError < AuthError
    end

    class ServerError < Error
    end

    class QueryError < Error
    end
  end
end
