# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
DataFile.create(file_name: 'testfile', file_contents: 'testcontent')
Merchant.create(name: 'Brandon Burnett', address: '4140 SE Washington St')
Item.create(name: '$10 of test item for $5', price: 5.00)
Purchaser.create(name: 'Kelila Eichstadt')
Order.create(data_file_id: 1, merchant_id: 1, item_id: 1, purchaser_id: 1, quantity: 1)
Order.create(data_file_id: 1, merchant_id: 1, item_id: 1, purchaser_id: 1, quantity: 2)
