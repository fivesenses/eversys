require "test_helper"

class Eversys::ProductTest < Test::Unit::TestCase
  test "should initialize" do
    product = Eversys::Product.new(client: api_client)
    assert_not_nil product
  end

  test "should get a list of products" do
    stub_get("machines/1234/products")
      .with(headers: stub_headers)
      .to_return(status: 200, body: fixture("get_machine_products_200.json"))

    products = Eversys::Product
      .new(client: api_client)
      .by_machine(machine_id: "1234")

    assert_equal 3, products.length
  end

  test "should get product counters by machine" do
    stub_get("machines/1234/product-counters")
      .with(headers: stub_headers)
      .to_return(status: 200, body: fixture("get_machine_product_counters_200.json"))

    product_counters = Eversys::Product
      .new(client: api_client)
      .counters_by_machine(machine_id: "1234")

    assert_equal 1103, product_counters.coffee
  end

  test "should get product counters by machine and side" do
    stub_get("machines/1234/product-counters/LEFT")
      .with(headers: stub_headers)
      .to_return(status: 200, body: fixture("get_machine_product_counters_by_side_200.json"))

    product_counters = Eversys::Product
      .new(client: api_client)
      .counters_by_machine_and_side(machine_id: "1234", side: "LEFT")

    assert_equal 223, product_counters.coffee
  end

  test "should get product parameters by machine" do
    stub_get("machines/1234/product-parameters")
      .with(headers: stub_headers)
      .to_return(status: 200, body: fixture("get_machine_product_parameters_200.json"))

    product_parameters = Eversys::Product
      .new(client: api_client)
      .parameters_by_machine(machine_id: "1234")

    assert_equal "RISTRETTO", product_parameters.first.generalSettings.type
  end
end
