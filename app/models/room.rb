class Room < ApplicationRecord
  belongs_to :hotel
  has_many :booking_rooms
  has_many :bookings, through: :booking_rooms
  
  enum :status, { available: 0, unavailable: 1 }, default: :available
  
  validates :room_number, presence: true, uniqueness: { scope: :hotel_id }
  validates :price, presence: true, numericality: { greater_than: 0 }

  def self.available_for_dates(check_in, check_out)
    where.not(id: unavailable_room_ids(check_in, check_out))
  end

  private

  def self.unavailable_room_ids(check_in, check_out)
    joins(:bookings)
      .where('bookings.checkin_day <= ? AND bookings.checkout_day >= ?', check_out, check_in)
      .pluck(:id)
  end
end
