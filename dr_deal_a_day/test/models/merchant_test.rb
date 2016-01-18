require 'test_helper'

class MerchantTest < ActiveSupport::TestCase
  should validate_presence_of("name")
  should validate_presence_of("address")
  should validate_uniqueness_of("name")

  test "should not save Merchant without name" do
    merchant = Merchant.new(address: '123 Fake St')
    assert_not merchant.save
  end

  test "should not save Merchant with duplicate name" do
    merchant = Merchant.new(name: "Brandon Burnett")
    assert_not merchant.save
  end

  test "should not save Merchant without price" do
    merchant = Merchant.new(name: "Test Name")
    assert_not merchant.save
  end

  test "should save Merchant with valid name and price" do
    merchant = Merchant.new(name: "Brandon Burnett2", address: '123 Fake St')
    assert merchant.save
  end
end
