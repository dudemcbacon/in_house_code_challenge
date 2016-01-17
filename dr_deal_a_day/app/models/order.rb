class Order < ActiveRecord::Base
  belongs_to :datafile
  belongs_to :merchant
  belongs_to :purchaser
  belongs_to :item

  def self.total_revenue
    Order.all.inject(0) { |sum, o| sum + o.order_revenue }
  end

  def order_revenue
    self.item.price * self.quantity
  end
end
