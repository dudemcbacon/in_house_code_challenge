class DataFile < ActiveRecord::Base
  has_many :orders

  def self.import(file)
    require 'csv'

    # Determine FileType
    if file.headers.match("Content-Type: text/csv")
      col_sep = ','
    elsif file.headers.match("Content-Type: text/tab-separated-values")
      col_sep = "\t"
    else
      raise UnsupportedFileType, "Unsupported file type"
    end

    # Create DataFile entry unless one already exists
    file_contents = file.read
    datafile = DataFile.where(file_name: file.original_filename, file_contents: file_contents)
    if datafile.empty?
      datafile = DataFile.create!(file_name: file.original_filename, file_contents: file_contents)
    else
      raise DuplicateError, "Duplicate file import detected"
    end

    # Find or create Purchaser, Merchant, and Item data unless they already exist
    orders = []
    CSV.foreach(file.path, headers: true, header_converters: :symbol, col_sep: col_sep) do |row|
      purchaser = Purchaser.find_or_create_by(name: row[:purchaser_name])
      merchant = Merchant.find_or_create_by(name: row[:merchant_name], address: row[:merchant_address])
      item = Item.find_or_create_by(name: row[:item_description], price: row[:item_price])
      # Add Orders
      orders << Order.create!(
        data_file_id: datafile.id,
        merchant_id: merchant.id,
        item_id: item.id,
        purchaser_id: purchaser.id,
        quantity: row[:purchase_count]
      )
    end
    orders
  end

end

class DuplicateError < StandardError
end

class UnsupportedFileType < StandardError
end
