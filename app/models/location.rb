class Location < ActiveRecord::Base
	validates :location_type, :name, :address,
    presence: true
  belongs_to :user
end
