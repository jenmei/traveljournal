class HotelsController < ApplicationController
  respond_to :html, :xml, :json

  before_filter :load_hotel, :except => [:new, :index, :create]
  
  def index
    respond_with(@hotels = Hotel.order('name'))
  end

  def show
  end

  def new
    @cities = City.order('name')
    respond_with(@hotel = Hotel.new)
  end

  def create
    @hotel = Hotel.new(params[:hotel])
    if @hotel.save
      flash[:notice] = "Hotel was created successfully."
      respond_with(@hotel, :status => :created, :location => @hotel) do |format|
        format.html { redirect_to @hotel }
      end
    else
      flash[:error] = @hotel.errors.full_messages.join("\n")
      @cities = City.order('name')
      respond_with(@hotel.errors, :status => :unprocessable_entity) do |format|
        format.html { render :action => :new }
      end
    end
  end

  protected

  def load_hotel
    @hotel = Hotel.find(params[:id])
  end
  
end
