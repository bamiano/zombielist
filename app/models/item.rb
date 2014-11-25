class Item < ActiveRecord::Base
	has_many :items_users
  has_many :users, :through => :items_users
end
