# frozen_string_literal: true

module Eversys
  class Client
    attr_reader :api_host, :api_version

    # creates an instance of the Eversys::Client
    #
    # @params opts [Hash] a hash with the configuration options
    def initialize(opts = {})
      @api_host = opts[:api_host] ||= Eversys::API_HOST
      @api_version = opts[:api_version] ||= Eversys::API_VERSION
      @api_token = opts[:api_token] ||= ENV["EVERSYS_TOKEN"]
    end

    # returns the base URL for REST operations
    # @returns [String]
    def base_url
      "#{@api_host}#{@api_version}/"
    end

    # Performs a GET operation
    #
    # @param url [String] The URL to perform a request on
    # @returns Net::HttpResponse
    #
    def get(url)
      perform_request(request: build_request({verb: "Get", url: url}))
    end

    # Performs a POST operation
    #
    # @param url [String] The URL to perform a request on
    # @param data [Hash] The data to POST to the URL
    # @returns Net::HttpResponse
    #
    def post(url, data)
      request = build_request({verb: "Post", url: url, data: data})
      perform_request(request)
    end

    # Performs a PATCH operation
    #
    # @param url [String] The URL to perform a request on
    # @param data [Hash] The data to PATCH the remote object with
    # @returns Net::HttpResponse
    #
    def patch(url, data)
      request = build_request({verb: "Patch", url: url, data: data})
      perform_request(request)
    end

    # Performs a DELETE operation
    #
    # @param url [String] The URL to perform a request on
    # @returns Net::HttpResponse
    #
    def delete(url)
      request = build_request({verb: "Delete", url: url})
      perform_request(request)
    end

    def dataset(response)
      JSON.parse(response.body)
    end

    protected

    # @param url [String] the URL to convert
    # @returns URI [URI]
    #
    def get_uri(url)
      URI(base_url + url)
    end

    # Build the actual Request object used to perform the operation
    #
    # @param opts [Hash] contains the request information
    # @returns [Net::HTTP::Request]
    #
    def build_request(opts)
      Eversys::RequestBuilder.new(client: self, opts: opts).request
    end

    # Performs the operation requested
    #
    # @param opts [Hash] contains the request information
    # @returns [Net::HTTP::Response]
    def perform_request(request:)
      Net::HTTP.start(request.uri.hostname, request.uri.port, use_ssl: true) do |http|
        http.request(request)
      end
    end
  end
end
