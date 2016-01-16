class Order < ActiveRecord::Base
  belongs_to :datafile
  belongs_to :merchant
  belongs_to :purchaser
  belongs_to :item
end
