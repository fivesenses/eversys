# frozen_string_literal: true

module Eversys
  class Machine < Eversys::Base
    def machines
      perform_get(url: "machines")
    end

    def machine(machine_id:)
      response = perform_get(url: "machines/#{machine_id}")
      response.first
    end

    def by_group(group_id:)
      perform_get(url: "group/#{group_id}/machines")
    end

    def counters(machine_id:)
      response = perform_get(url: "machines/machine-counters/#{machine_id}")
      response.first
    end
  end
end
