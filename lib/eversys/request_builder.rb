# frozen_string_literal: true

module Eversys
  class RequestBuilder
    attr_accessor :request
    attr_reader :verb, :url, :data, :token

    # @param client [Eversys::Client]
    # @param opts [Hash] Options used to build the request
    def initialize(client:, opts: {})
      @client = client
      @verb = opts[:verb] if opts.has_key?(:verb)
      @url = opts[:url] if opts.has_key?(:url)
      @token = opts[:token] if opts.has_key?(:token)
      build
    end

    # Create the appropriate request object
    #
    # Populates @request with the constructed object
    def build
      @request = request_object.new(uri)
      @request.content_type = "application/json"
      add_token
      add_data
    end

    # If an etag is supplied, add it to the request in an ['If-Match'] header
    #
    def add_token
      return if @token.nil?
      @request["Authorization"] = "Bearer #{@token}"
    end

    # If form data is supplied, add it to the request body as JSON
    #
    def add_data
      return if @data.nil?
      @request.body = JSON.generate(@data)
    end

    # @returns [Net::HTTP::Request] object, based on the verb supplied in the
    # initialization opts Hash
    #
    def request_object
      Object.const_get("Net::HTTP::#{@verb.capitalize}")
    end

    # Contstruct URI for the request
    #
    # @returns [URI]
    #
    def uri
      URI(@client.base_url + @url)
    end
  end
end
