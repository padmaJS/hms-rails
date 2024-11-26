class RoomsController < ApplicationController
  def index
    @checkin_day = params[:checkin_day].present? ? Date.parse(params[:checkin_day]) : Date.today
    @checkout_day = params[:checkout_day].present? ? Date.parse(params[:checkout_day]) : Date.tomorrow

    if @checkin_day && @checkout_day
      @rooms = Room.available_for_dates(@checkin_day, @checkout_day)
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