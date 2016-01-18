class Purchaser < ActiveRecord::Base
  has_many :orders

  validates :name, presence: true, uniqueness: true
  validates_associated :orders
end
