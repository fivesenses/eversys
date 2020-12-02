# frozen_string_literal: true

module Eversys
  class Statistics < Eversys::Base
    def data_by_machine(machine_id:)
      results = perform_get(url: "machines/statistic-data/#{machine_id}")
      results.first
    end

    def data_by_group(group_id:)
      perform_get(url: "groups/#{group_id}/statistic-data")
    end

    def views_by_group(group_id:)
      results = perform_get(url: "dashboards/groups/statistic-views/#{group_id}")
      results.first
    end

    def views_by_user(user_id:)
      results = perform_get(url: "dashboards/users/statistic-views/#{user_id}")
      results.first
    end
  end
end
