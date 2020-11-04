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
end
