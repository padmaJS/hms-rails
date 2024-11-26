class Admin::BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin

  def index
    @bookings = Booking.includes(:user, :rooms).all
  end

  def update
    @booking = Booking.find(params[:id])
    if @booking.update(booking_params)
      redirect_to admin_bookings_path, notice: 'Booking status updated successfully.'
    else
      redirect_to admin_bookings_path, alert: 'Unable to update booking status.'
    end
  end

  def cancel
    @booking = Booking.find(params[:id])
    @booking.update(status: :cancelled)
    redirect_to admin_bookings_path, notice: 'Booking cancelled successfully.'
  end

  private

  def ensure_admin
    redirect_to root_path, alert: 'Access denied.' unless current_user.admin?
  end

  def booking_params
    params.require(:booking).permit(:status)
  end
end