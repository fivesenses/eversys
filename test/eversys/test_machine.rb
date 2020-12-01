require "test_helper"

class Eversys::MachineTest < Test::Unit::TestCase
  test "should initialize" do
    machine = Eversys::Machine.new(client: api_client)
    assert_not_nil machine
  end

  test "should get a list of machines" do
    stub_get("machines")
      .with(headers: stub_headers)
      .to_return(status: 200, body: fixture("get_machines_200.json"))

    machines = Eversys::Machine
      .new(client: api_client)
      .machines

    assert_equal 1, machines.length
    assert_equal "<Customer Name>", machines.first.customer.name
  end

  test "should get a machine's details" do
    stub_get("machines/1234")
      .with(headers: stub_headers)
      .to_return(status: 200, body: fixture("get_machine_200.json"))

    machine = Eversys::Machine.new(client: api_client).machine(machine_id: "1234")
    assert_equal "<Customer Name>", machine.customer.name
  end

  test "should raise an error when unauthorized" do
    stub_get("machines")
      .with(headers: stub_headers)
      .to_return(status: 401, body: fixture("401_token_missing.json"))

    assert_raise Eversys::AuthenticationError do
      machines = Eversys::Machine
        .new(client: api_client)
        .machines
    end
  end

  test "should get machine counters" do
    stub_get("machines/machine-counters/1234")
      .with(headers: stub_headers)
      .to_return(status: 200, body: fixture("get_machine_counters_200.json"))

    counters = Eversys::Machine.new(client: api_client).counters(machine_id: "1234")
    assert_equal 228.492, counters.water.totalQuantity
  end

  test "should get a list of machines by group" do
    stub_get("group/1234/machines")
      .with(headers: stub_headers)
      .to_return(status: 200, body: fixture("get_group_machines_200.json"))

    machines = Eversys::Machine.new(client: api_client).by_group(group_id: "1234")
    assert_equal "<Customer Name>", machines.first.customer.name
  end

  test "should get a machine's events" do
    stub_get("machines/1234/events")
      .with(headers: stub_headers)
      .to_return(status: 200, body: fixture("get_machine_events_200.json"))

    events = Eversys::Machine.new(client: api_client).events(machine_id: "1234")
    assert_equal 16, events.length
    assert_equal "Display Wake Up", events.first.text
  end

  test "should get a machine's errors" do
    stub_get("machines/1234/errors")
      .with(headers: stub_headers)
      .to_return(status: 200, body: fixture("get_machine_errors_200.json"))

    errors = Eversys::Machine.new(client: api_client).errors(machine_id: "1234")
    assert_equal 10, errors.length
    assert_equal 3, errors.first.level
  end

  test "should get a machine's rinse data" do
    stub_get("machines/1234/rinses")
      .with(headers: stub_headers)
      .to_return(status: 200, body: fixture("get_machine_rinses_200.json"))

    rinses = Eversys::Machine.new(client: api_client).rinses(machine_id: "1234")
    assert_equal 4, rinses.length
    assert_equal "CLEANING_RINSE", rinses.first.type
  end

  test "should get a machine's installation data" do
    stub_get("machines/installations/1234")
      .with(headers: stub_headers)
      .to_return(status: 200, body: fixture("get_machine_installations_200.json"))

    installations = Eversys::Machine.new(client: api_client).installations(machine_id: "1234")

    assert_equal 0, installations.first.linePressure
  end

  test "should get a machine's cleaning data" do
    stub_get("machines/1234/cleanings")
      .with(headers: stub_headers)
      .to_return(status: 200, body: fixture("get_machine_cleanings_200.json"))

    cleanings = Eversys::Machine.new(client: api_client).cleanings(machine_id: 1234)

    assert_equal 4, cleanings.length
    assert_equal "YES", cleanings.first.tabsStatus.left
  end
end
