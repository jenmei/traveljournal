class HotelsController < ApplicationController
  def index
    @hotels = Hotel.order('name')
  end

  def show
    @hotel = Hotel.find(params[:id])
  end
end
