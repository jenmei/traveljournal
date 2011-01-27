class HotelsController < ApplicationController
  respond_to :html, :xml, :json

  before_filter :load_hotel, :except => [:new, :index, :create]

  def index
    respond_with(@hotels = Hotel.order('name'))
  end

  def show
  end

  protected

  def load_hotel
    @hotel = Hotel.find(params[:id])
  end
end
