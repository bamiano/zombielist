class Favorite < ActiveRecord::Base
	belongs_to :user
	
	validates :name,  :image, :link,
    presence: true


end
