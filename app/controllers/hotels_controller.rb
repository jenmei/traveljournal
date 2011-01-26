class HotelsController < ApplicationController
  def index
    @hotels = Hotel.order('name')
  end
end
