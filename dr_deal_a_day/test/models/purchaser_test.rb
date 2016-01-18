require 'test_helper'

class PurchaserTest < ActiveSupport::TestCase
  should validate_presence_of('name')
  should validate_uniqueness_of('name')

  test "should not save Purchaser without name" do
    purchaser = Purchaser.new
    assert_not purchaser.save
  end

  test "should not save Purchaser with duplicate name" do
    purchaser = Purchaser.new(name: "Kelila Eichstadt")
    assert_not purchaser.save
  end


  test "should save Purchaser with valid name and price" do
    purchaser = Purchaser.new(name: 'Brandon Burnett')
    assert purchaser.save
  end
end
