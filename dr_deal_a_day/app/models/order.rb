class Order < ActiveRecord::Base
  belongs_to :datafile
  belongs_to :merchant
  belongs_to :purchaser
  belongs_to :item

  validates :data_file_id, presence: true
  validates :merchant_id, presence: true
  validates :purchaser_id, presence: true
  validates :item_id, presence: true
  validates :quantity, presence: true

  def self.total_revenue
    Order.all.inject(0) { |sum, o| sum + o.order_revenue }
  end

  def order_revenue
    self.item.price * self.quantity
  end
end
