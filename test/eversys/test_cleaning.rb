require "test_helper"

class Eversys::CleaningTest < Test::Unit::TestCase
  test "should get cleaning history for a machine" do
    stub_get("machines/1234/cleanings")
      .with(headers: stub_headers)
      .to_return(status: 200,
                 body: fixture("get_machine_cleanings_200.json"))
    cleanings = Eversys::Cleaning
      .new(client: api_client)
      .by_machine(machine_id: 1234)

    assert_equal "YES", cleanings.first.tabsStatus.left
  end

  test "should get a machines cleaning ratings" do
    stub_get("machines/cleaning-ratings/1234")
      .with(headers: stub_headers)
      .to_return(status: 200,
                 body: fixture("get_machine_cleaning_ratings_200.json"))

    cleaning = Eversys::Cleaning
      .new(client: api_client)
      .cleaning_ratings_by_machine(machine_id: 1234)

    assert_equal 0, cleaning.first.cleaningsLast7Days
  end

  test "should get a groups cleaning ratings" do
    stub_get("groups/1234/cleaning-ratings")
      .with(headers: stub_headers)
      .to_return(status: 200,
                 body: fixture("get_group_cleaning_ratings_200.json"))

    cleaning = Eversys::Cleaning
      .new(client: api_client)
      .cleaning_ratings_by_group(group_id: 1234)

    assert_equal 3, cleaning.length
    assert_equal 0, cleaning.first.cleaningsLast7Days
  end

  test "should get a groups cleaning views" do
    stub_get("dashboards/groups/cleaning-views/1234")
      .with(headers: stub_headers)
      .to_return(status: 200,
                 body: fixture("get_group_cleaning_views_200.json"))

    cleaning = Eversys::Cleaning
      .new(client: api_client)
      .cleaning_views_by_group(group_id: 1234)

    assert_nil cleaning.first.avgCleaningRating
  end

  test "should get a users cleaning views" do
    stub_get("dashboards/users/cleaning-views/1234")
      .with(headers: stub_headers)
      .to_return(status: 200,
                 body: fixture("get_user_cleaning_views_200.json"))

    cleaning = Eversys::Cleaning
      .new(client: api_client)
      .cleaning_views_by_user(user_id: 1234)

    assert_nil cleaning.first.avgCleaningRating
  end
end
