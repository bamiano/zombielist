class Location < ActiveRecord::Base
	validates :type, :name, :address,
    presence: true
end
