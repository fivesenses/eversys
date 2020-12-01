# frozen_string_literal: true

module Eversys
  class Milk < Eversys::Base
    def temp_ratings_by_machine(machine_id:)
      perform_get(url: "machines/milk-temp-ratings/#{machine_id}")
    end

    def temp_ratings_by_group(group_id:)
      perform_get(url: "groups/#{group_id}/milk-temp-ratings")
    end

    # @param group_id [String] the GUID
    def temp_views_by_group(group_id:)
      perform_get(url: "dashboards/groups/milk-temp-views/#{group_id}")
    end

    # @param user_id [String]
    def temp_views_by_user(user_id:)
      perform_get(url: "dashboards/users/milk-temp-views/#{user_id}")
    end
  end
end
