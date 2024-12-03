class Room < ApplicationRecord
  belongs_to :hotel
  has_many :booking_rooms
  has_many :bookings, through: :booking_rooms
  
  enum :status, { available: 0, unavailable: 1 }, default: :available
  
  validates :room_number, presence: true, uniqueness: { scope: :hotel_id }
  validates :price, presence: true, numericality: { greater_than: 0 }

  scope :available_for_dates, ->(checkin_day, checkout_day) {
    left_joins(:bookings)
      .where('bookings.id IS NULL OR bookings.checkin_day > ? OR (bookings.checkout_day < ? AND rooms.status = ?)', checkout_day, checkin_day, 'available')
      .distinct
  }

  private

  def self.unavailable_room_ids(check_in, check_out)
    joins(:bookings)
      .where('bookings.checkin_day <= ? AND bookings.checkout_day >= ?', check_out, check_in)
      .pluck(:id)
  end
end
