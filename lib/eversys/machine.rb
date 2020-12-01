# frozen_string_literal: true

module Eversys
  class Machine < Eversys::Base
    def machines
      perform_get(url: "machines")
    end

    def machine(machine_id:)
      results = perform_get(url: "machines/#{machine_id}")
      results.first
    end

    def by_group(group_id:)
      perform_get(url: "group/#{group_id}/machines")
    end

    def counters(machine_id:)
      results = perform_get(url: "machines/machine-counters/#{machine_id}")
      results.first
    end

    def events(machine_id:)
      perform_get(url: "machines/#{machine_id}/events")
    end

    def errors(machine_id:)
      perform_get(url: "machines/#{machine_id}/errors")
    end

    def rinses(machine_id:)
      perform_get(url: "machines/#{machine_id}/rinses")
    end

    def installations(machine_id:)
      perform_get(url: "machines/installations/#{machine_id}")
    end

    def cleanings(machine_id:)
      perform_get(url: "machines/#{machine_id}/cleanings")
    end
  end
end
