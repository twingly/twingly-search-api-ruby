# frozen_string_literal: true

module Twingly
  module LiveFeed
    class Error < StandardError
      def self.from_api_response(code, message)
        error =
          case code.to_s
          when /^400/, /^404/
            QueryError
          when /^401/
            AuthError
          else
            ServerError
          end

        error.new("#{message} (code: #{code})")
      end
    end

    class AuthError < Error
    end

    class ServerError < Error
    end

    class QueryError < Error
    end
  end
end
