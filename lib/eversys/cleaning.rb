# frozen_string_literal: true

module Eversys
  class Cleaning < Eversys::Base
    def cleaning_ratings_by_machine(machine_id:)
      perform_get(url: "machines/cleaning-ratings/#{machine_id}")
    end

    def cleaning_ratings_by_group(group_id:)
      perform_get(url: "groups/#{group_id}/cleaning-ratings")
    end

    def cleaning_views_by_group(group_id:)
      perform_get(url: "dashboards/groups/cleaning-views/#{group_id}")
    end

    def cleaning_views_by_user(user_id:)
      perform_get(url: "dashboards/users/cleaning-views/#{user_id}")
    end
  end
end
