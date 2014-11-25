class User < ActiveRecord::Base

  has_secure_password

  has_many :locations
  has_many :favorites

  has_many :items_users
  has_many :items, :through => :items_users

  validates :email,
    uniqueness: true,
    presence: true,
    format: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :password,
    presence: true,
    length: {minimum: 5},
    on: :create
end