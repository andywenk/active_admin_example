class User < ActiveRecord::Base
  has_many :orders
  attr_accessible :first_name, :last_name
end
