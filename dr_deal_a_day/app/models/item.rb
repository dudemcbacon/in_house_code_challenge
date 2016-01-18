class Item < ActiveRecord::Base
  has_many :orders

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true
  validates_associated :orders
end
