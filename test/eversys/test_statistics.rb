require "test_helper"

class Eversys::StatisticsTest < Test::Unit::TestCase
  test "should get statistics for a machine" do
    stub_get("machines/statistic-data/1234")
      .with(headers: stub_headers)
      .to_return(status: 200, body: fixture("get_statistics_by_machine_200.json"))

    statistics = Eversys::Statistics
      .new(client: api_client)
      .by_machine(machine_id: "1234")

    assert_equal 0, statistics.productsToday
  end

  test "should get statistics for a group" do
    stub_get("groups/1234/statistic-data")
      .with(headers: stub_headers)
      .to_return(status: 200, body: fixture("get_statistics_by_group_200.json"))

    statistics = Eversys::Statistics
      .new(client: api_client)
      .by_group(group_id: "1234")

    assert_equal 3, statistics.length
  end
end
