class OrderItem < ActiveRecord::Base
  belongs_to :order
  attr_accessible :order_id, :product_id, :quantity
end
