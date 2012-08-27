class Order < ActiveRecord::Base
  has_many :order_items
  belongs_to :user
  attr_accessible :user_id
end
