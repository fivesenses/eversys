# frozen_string_literal: true

module Eversys
  class Statistics < Eversys::Base
    def by_machine(machine_id:)
      results = perform_get(url: "machines/statistic-data/#{machine_id}")
      results.first
    end

    def by_group(group_id:)
      perform_get(url: "groups/#{group_id}/statistic-data")
    end

    def by_user(user_id:)
      perform_get(url: "dashboards/users/statistic-views/#{user_id}")
    end
  end
end
