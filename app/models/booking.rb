class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :hotel
  has_many :booking_rooms
  has_many :rooms, through: :booking_rooms
  
  enum :status, { requested: 0, confirmed: 1, ongoing: 2, completed: 3, cancelled: 4 }, default: :requested
  
  validates :checkin_day, :checkout_day, :total_amount, presence: true
end
