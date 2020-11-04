# frozen_string_literal: true

# Provides an interface to the Eversys REST API as documented here:
# https://developers.eversys-telemetry.com

module Eversys
  class Base
    attr_reader :client

    # @param client [Eversys::Client]
    def initialize(client:)
      @client = client.nil? ? Eversys::Client.new : client
    end

    # @param response [Net::HTTPResponse]
    def process(response:)
      Eversys::Response::ResponseHandler
        .new(dataset: @client.dataset(response))
        .compiled_data
    end

    private

    # Check to see if the response contains an error and raise an error if
    # required
    #
    # @param response [Net::HTTPResponse]
    #
    def handle_error(response:)
      if response.code == "401"
        raise Eversys::AuthenticationError.new("AuthenticationError", response)
      end

      if response.code == "429"
        raise Eversys::RateLimitError.new("Rate Limited", response)
      end

      if ["400", "500"].include?(response.code)
        raise Eversys::ServiceError.new("Service Error", response)
      end

      unless ["200", "201", "202", "203", "204"].include?(response.code)
        raise Eversys::ServiceUnavailableError.new("Unknown Error", response)
      end
    end
  end
end
