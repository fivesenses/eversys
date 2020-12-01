# frozen_string_literal: true

module Eversys
  class Product < Eversys::Base
    def by_machine(machine_id:, opts: {})
      perform_get(url: "machines/#{machine_id}/products")
    end

    def counters_by_machine(machine_id:)
      results = perform_get(url: "machines/#{machine_id}/product-counters")
      results.first
    end

    def counters_by_machine_and_side(machine_id:, side:)
      results = perform_get(url: "machines/#{machine_id}/product-counters/#{side}")
      results.first
    end

    def parameters_by_machine(machine_id:)
      perform_get(url: "machines/#{machine_id}/product-parameters")
    end

    def parameters_by_machine_and_side(machine_id:, side:)
      perform_get(url: "machines/#{machine_id}/product-parameters/#{side}")
    end

    def parameters_by_machine_and_side_and_product(machine_id:, side:, product_id:)
      perform_get(url: "machines/#{machine_id}/product-parameters/#{side}/#{product_id}")
    end
  end
end
