require "test_helper"

class Eversys::MilkTest < Test::Unit::TestCase
  test "should initialize" do
    milk = Eversys::Milk.new(client: api_client)
    assert_not_nil milk
  end

  test "should get a machines milk temp ratings" do
    stub_get("machines/milk-temp-ratings/1234")
      .with(headers: stub_headers)
      .to_return(status: 200, body: fixture("get_machine_milk_temp_ratings_200.json"))

    milk = Eversys::Milk.new(client: api_client).temp_ratings_by_machine(machine_id: 1234)
    assert_equal 70, milk.first.nominalMilkTemp
  end

  test "should get a group's milk temp ratings" do
    stub_get("groups/1234/milk-temp-ratings")
      .with(headers: stub_headers)
      .to_return(status: 200, body: fixture("get_group_milk_temp_ratings_200.json"))

    milk = Eversys::Milk.new(client: api_client).temp_ratings_by_group(group_id: 1234)
    assert_equal 3, milk.length
    assert_equal 70, milk.first.nominalMilkTemp
  end

  test "should get a group's milk temp views" do
    stub_get("dashboards/groups/milk-temp-views/1234")
      .with(headers: stub_headers)
      .to_return(status: 200, body: fixture("get_group_milk_temp_views_200.json"))

    milk = Eversys::Milk.new(client: api_client).temp_views_by_group(group_id: 1234)

    assert_nil milk.first.avgMilkTempRating
  end

  test "should get a users milk temp views" do
    stub_get("dashboards/users/milk-temp-views/1234")
      .with(headers: stub_headers)
      .to_return(status: 200, body: fixture("get_user_milk_temp_views_200.json"))

    milk = Eversys::Milk.new(client: api_client).temp_views_by_user(user_id: 1234)

    assert_nil milk.first.avgMilkTempRating
  end
end
