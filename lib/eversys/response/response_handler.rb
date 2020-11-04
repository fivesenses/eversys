# frozen_string_literal: true

module Eversys::Response
  class ResponseHandler
    attr_accessor :dataset
    attr_accessor :compiled_data

    def initialize(dataset:)
      @compiled_data = []
      @dataset = dataset
      process
    end

    def process
      @dataset.is_a?(Array) ? process_array : process_data(data: @dataset)
    end

    def process_array
      @dataset.each { |data| process_data(data: data) }
    end

    def process_data(data:)
      @compiled_data << JSON.parse(sanitize(data: data), object_class: OpenStruct)
    end

    def sanitize(data:)
      data.is_a?(Hash) ? data.to_json : data
    end
  end
end
