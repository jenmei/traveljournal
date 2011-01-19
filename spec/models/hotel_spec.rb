require 'spec_helper'

describe Hotel do
  it "should be valid with valid attributes" do
    @hotel = Hotel.new(:name => "Travelodge")
    @hotel.should be_valid
  end
  
  it "should not be valid without a name" do
    @hotel = Hotel.new
    @hotel.should_not be_valid    
  end

  it "should not be valid with a name shorter than 2 characters" do
    @hotel = Hotel.new(:name => "A")
    @hotel.should_not be_valid    
  end

  it "should have a city" do
    @hotel = Hotel.new()
    @hotel.should respond_to(:city)
  end
  
  it "should return visited hotels" do
    @visited_hotel = Hotel.create(
      :name => "Been There Motel", :visited => true
    )
    @unvisited_hotel = Hotel.create(
      :name => "Let's Go Lodge", :visited => false
    )
    Hotel.yet_to_visit.should eq([@unvisited_hotel])
  end
  
end

