class HomeController < ApplicationController
  def index
    @hotel =  Hotel.first
  end

  def search
    checkin_day = params[:checkin_day]
    checkout_day = params[:checkout_day]
    redirect_to rooms_path(checkin_day: checkin_day, checkout_day: checkout_day)
  end
end
