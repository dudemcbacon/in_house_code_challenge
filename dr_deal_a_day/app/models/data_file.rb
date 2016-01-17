class DataFile < ActiveRecord::Base
  has_many :orders

  def self.import(file)
    require 'csv'

    datafile = DataFile.find_or_create_by(file_name: file.original_filename, file_contents: file.tempfile.read)

    orders = []
    CSV.foreach(file.path, headers: true, header_converters: :symbol) do |row|
      purchaser = Purchaser.find_or_create_by(name: row[:purchaser_name])
      merchant = Merchant.find_or_create_by(name: row[:merchant_name], address: row[:merchant_address])
      item = Item.find_or_create_by(name: row[:item_description], price: row[:item_price])
      orders << Order.create!(data_file_id: datafile.id, merchant_id: merchant.id, item_id: item.id, purchaser_id: purchaser.id, quantity: row[:purchase_count])
    end
    orders
  end

  def self.total_revenue
    Order.all.inject(0) { |sum, o| sum + (o.quantity * o.item.price) }
  end
end
