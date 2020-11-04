require "test_helper"

class Eversys::ClientTest < Test::Unit::TestCase
  test "should initialize a client object" do
    client = api_client

    assert_not_nil client
    assert_equal "https://api.eversys-telemetry.com", client.api_host
  end

  test "should perform a get request" do
    client = api_client

    client.expects(:perform_request).at_least_once
    client.get("/machines")
  end
end
