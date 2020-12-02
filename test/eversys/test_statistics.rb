require "test_helper"

class Eversys::StatisticsTest < Test::Unit::TestCase
  test "should get statistics for a machine" do
    stub_get("machines/statistic-data/1234")
      .with(headers: stub_headers)
      .to_return(status: 200,
                 body: fixture("get_statistics_data_by_machine_200.json"))

    statistics = Eversys::Statistics
      .new(client: api_client)
      .data_by_machine(machine_id: "1234")

    assert_equal 0, statistics.productsToday
  end

  test "should get statistics for a group" do
    stub_get("groups/1234/statistic-data")
      .with(headers: stub_headers)
      .to_return(status: 200,
                 body: fixture("get_statistics_data_by_group_200.json"))

    statistics = Eversys::Statistics
      .new(client: api_client)
      .data_by_group(group_id: "1234")

    assert_equal 3, statistics.length
  end

  test "should get statistic views by group" do
    stub_get("dashboards/groups/statistic-views/1234")
      .with(headers: stub_headers)
      .to_return(status: 200,
                 body: fixture("get_statistics_views_by_group_200.json"))

    stats = Eversys::Statistics
      .new(client: api_client)
      .views_by_group(group_id: 1234)

    assert_equal 12, stats.totalProductsToday
  end

  test "should get statistic views by user" do
    stub_get("dashboards/users/statistic-views/1234")
      .with(headers: stub_headers)
      .to_return(status: 200,
                 body: fixture("get_statistics_views_by_user_200.json"))

    stats = Eversys::Statistics
      .new(client: api_client)
      .views_by_user(user_id: 1234)

    assert_equal 20, stats.totalProductsToday
  end
end
