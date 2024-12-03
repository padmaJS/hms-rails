class PagesController < ApplicationController
  def about
    @hotel = Hotel.first
  end
end
