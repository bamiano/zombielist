class Favorite < ActiveRecord::Base
	validates :name, :link, :image,
    presence: true
end
