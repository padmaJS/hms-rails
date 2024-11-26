class Hotel < ApplicationRecord
  has_many :reviews
  has_many :rooms
  has_many :bookings
  
  validates :name, :address, :checkin_time, :checkout_time, :email, :phone_number, presence: true
end
