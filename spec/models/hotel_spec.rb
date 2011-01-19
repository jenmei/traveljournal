require 'spec_helper'

describe Hotel do
  it "should exist" do
    @hotel = Hotel.new
    @hotel.should be_valid
  end
end

