class Location < ActiveRecord::Base
	belongs_to :user

	validates :location_type, :name, :address, presence: true

end
