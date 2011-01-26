class HotelsController < ApplicationController

  before_filter :load_hotel, :except => [:new, :index, :create]

  def index
    @hotels = Hotel.order('name')
  end

  def show
  end

  protected

  def load_hotel
    @hotel = Hotel.find(params[:id])
  end
end
