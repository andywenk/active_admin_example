class Order < ActiveRecord::Base
  has_many :products
  attr_accessible :product_id, :total, :user_id
end
