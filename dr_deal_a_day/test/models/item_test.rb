require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  should validate_presence_of('name')
  should validate_uniqueness_of('name')
  should validate_presence_of('price')

  test "should not save Item without name" do
    item = Item.new(price: 1.50)
    assert_not item.save
  end

  test "should not save Item with duplicate name" do
    item = Item.new(name: "$10 off test item for $5")
    assert_not item.save
  end

  test "should not save Item without price" do
    item = Item.new(name: "$15 off test item for $5")
    assert_not item.save
  end

  test "should save Item with valid name and price" do
    item = Item.new(name: "$15 off test item for $5", price: 5.00)
    assert item.save
  end
end
