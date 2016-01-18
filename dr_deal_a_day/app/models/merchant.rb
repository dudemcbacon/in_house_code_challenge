class Merchant < ActiveRecord::Base
  has_many :orders

  validates :name, presence: true, uniqueness: true
  validates :address, presence: true
  validates_associated :orders
end
