class BookingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @bookings = current_user.bookings
  end

  def show
    @booking = Booking.find(params[:id])
  end

  def new
    @booking = Booking.new
    @room = Room.find(params[:room_id])
  end

  def create
    @room = Room.find(params[:room_id])
    @booking = current_user.bookings.new(booking_params)
    @booking.hotel = @room.hotel
    @booking.status = :requested
    @booking.total_amount = calculate_total_amount

    if @booking.save
      @booking.booking_rooms.create(room_id: @room.id)
      redirect_to booking_path(@booking), notice: 'Booking was successfully created.'
    else
      redirect_to room_path(@room), alert: 'Unable to create booking.'
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:checkin_day, :checkout_day)
  end

  def calculate_total_amount
    total_nights = (Date.parse(params[:booking][:checkout_day]) - Date.parse(params[:booking][:checkin_day])).to_i
    @room.price * total_nights
  end
end