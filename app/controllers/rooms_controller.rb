class RoomsController < ApplicationController
  def index
    @checkin_day = params[:checkin_day].present? ? Date.parse(params[:checkin_day]) : Date.today
    @checkout_day = params[:checkout_day].present? ? Date.parse(params[:checkout_day]) : Date.tomorrow

    if @checkin_day && @checkout_day
      hotel_checkin_time = Hotel.first.checkin_time
      now = Time.zone.now
      today = Date.today

      hotel_checkin_time_only = hotel_checkin_time.strftime("%H:%M:%S")
      now_time_only = now.strftime("%H:%M:%S")

      puts "hotel_checkin_time: #{hotel_checkin_time_only}"
      puts "now: #{now_time_only}"
      puts "today: #{today}"
      puts "checkin_day: #{@checkin_day}"
      puts "checkout_day: #{@checkout_day}"

      if (@checkin_day == today && now_time_only < hotel_checkin_time_only) || @checkin_day > today
        available_rooms = Room.left_joins(:bookings)
                              .where('bookings.id IS NULL OR bookings.checkin_day > ? OR (bookings.checkout_day < ? AND rooms.status = ?)', @checkout_day, @checkin_day, 0)
                              .distinct

        puts "available_rooms: #{available_rooms}"

        overlapping_available_rooms = Room.left_joins(:bookings)
                                          .where('(bookings.checkin_day >= ? OR bookings.checkout_day <= ? OR (bookings.checkin_day <= ? AND bookings.checkout_day >= ?)) AND bookings.status NOT IN (?)', @checkin_day, @checkout_day, @checkin_day, @checkout_day, [1, 2])
                                          .distinct

        available_rooms = (available_rooms + overlapping_available_rooms).uniq

        unavailable_rooms = Room.left_joins(:bookings)
                                .where('((bookings.checkin_day >= ? AND bookings.checkout_day >= ? AND bookings.checkin_day <= ?) OR (bookings.checkout_day <= ? AND bookings.checkin_day <= ? AND bookings.checkin_day >= ?) OR (bookings.checkin_day <= ? AND bookings.checkout_day >= ?)) AND bookings.status IN (?) OR rooms.status = ?', @checkin_day, @checkout_day, @checkout_day, @checkout_day, @checkin_day, @checkin_day, @checkin_day, @checkout_day, [1, 2], 1)
                                .distinct
                                .pluck(:id)

        @rooms = available_rooms.reject { |room| unavailable_rooms.include?(room.id) }
      else
        @rooms = []
      end
    else
      @rooms = Room.all
    end
  end

  def show
    @room = Room.find(params[:id])
    @checkin_day = params[:checkin_day].present? ? Date.parse(params[:checkin_day]) : Date.today
    @checkout_day = params[:checkout_day].present? ? Date.parse(params[:checkout_day]) : Date.tomorrow
    @booking = Booking.new
  end
end