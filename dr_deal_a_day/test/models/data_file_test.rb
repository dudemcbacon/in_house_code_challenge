require 'test_helper'

class DataFileTest < ActiveSupport::TestCase
  should validate_presence_of('file_name')
  should validate_uniqueness_of('file_name')
  should validate_presence_of('file_contents')
  should validate_uniqueness_of('file_contents')

  test 'should not save DataFile without file_name' do
    datafile = DataFile.new(file_contents: 'testcontent')
    assert_not datafile.save
  end

  test 'should not save DataFile with duplicate file_name' do
    datafile = DataFile.new(file_name: 'example_data.csv', file_contents: 'testcontent')
    assert_not datafile.save
  end

  test 'should not save DataFile without file_contents' do
    datafile = DataFile.new(file_name: 'example_data.csv')
    assert_not datafile.save
  end

  test 'should not save DataFile with duplicate file_contents' do
    file_contents = "purchaser name,item description,item price,purchase count,merchant address,merchant name\nSnake Plissken,$10 off $20 of food,10.0,2,987 Fake St,\"Bob, Larry, and Jan's Pizza\"\nAmy Pond,$30 of awesome for $10,10.0,5,456 Unreal Rd,Tom's Awesome Shop\nMarty McFly,$20 Sneakers for $5,5.0,1,123 Fake St,Sneaker Store Emporium\nSnake Plissken,$20 Sneakers for $5,5.0,4,123 Fake St,Sneaker Store Emporium\n"
    datafile = DataFile.new(file_name: 'testname', file_contents: file_contents)
    assert_not datafile.save
  end

  test 'should save DataFile with valid file_name and file_contents' do
    file_contents = "purchaser name,item description,item price,purchase count,merchant address,merchant name\nSnake2 Plissken,$10 off $20 of food,10.0,2,987 Fake St,\"Bob, Larry, and Jan's Pizza\"\nAmy Pond,$30 of awesome for $10,10.0,5,456 Unreal Rd,Tom's Awesome Shop\nMarty McFly,$20 Sneakers for $5,5.0,1,123 Fake St,Sneaker Store Emporium\nSnake Plissken,$20 Sneakers for $5,5.0,4,123 Fake St,Sneaker Store Emporium\n"
    datafile = DataFile.new(file_name: 'testname', file_contents: file_contents)
    assert datafile.save
  end
end
