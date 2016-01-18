require 'test_helper'
require 'pry'

class OrderTest < ActiveSupport::TestCase
  should validate_presence_of('quantity')
  should validate_presence_of('data_file_id')
  should validate_presence_of('merchant_id')
  should validate_presence_of('purchaser_id')
  should validate_presence_of('item_id')

  test "should not save Order without quantity" do
    order = Order.new(data_file_id: 1, merchant_id: 1, purchaser_id: 1, item_id: 1)
    assert_not order.save
  end

  test "should not save Order without data_file_id" do
    order = Order.new(merchant_id: 1, purchaser_id: 1, item_id: 1, quantity: 1)
    assert_not order.save
  end

  test "should not save Order without merchant_id" do
    order = Order.new(data_file_id: 1, purchaser_id: 1, item_id: 1, quantity: 1)
    assert_not order.save
  end

  test "should not save Order without purchaser_id" do
    order = Order.new(data_file_id: 1, merchant_id: 1, item_id: 1, quantity: 1)
    assert_not order.save
  end

  test "should not save Order without item_id" do
    order = Order.new(data_file_id: 1, merchant_id: 1, purchaser_id: 1, quantity: 1)
    assert_not order.save
  end

  test "should save Order with valid data" do
    order = Order.new(data_file_id: 1, merchant_id: 1, purchaser_id: 1, item_id: 1, quantity: 1)
    assert order.save
  end

  test "should be able to determine #order_revenue" do
    assert_equal 1.5, Order.find_by_id(1).order_revenue
    assert_equal 3.0, Order.find_by_id(2).order_revenue
  end

  test "should be able to determine ::total_revenue of all Orders" do
    assert_equal 4.5, Order.total_revenue
  end
end
