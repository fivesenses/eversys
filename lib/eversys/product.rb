# frozen_string_literal: true

module Eversys
  class Product < Eversys::Base
    def by_machine(machine_id:, opts: {})
      @client.get("/machine/#{machine_id}/products")
    end
  end
end
