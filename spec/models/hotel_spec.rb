require 'spec_helper'

describe Hotel do
  before do
    @detroit = Factory.create(:city, :name => "detroit")
  end

  describe "validations" do
    it "should be valid with valid attributes" do
      # This should probably stay the same, since a factory
      # would automatically be valid. Unless, of course,
      # we wanted to test the factory. :-)
      @st_clair = Hotel.new(
        :name => "The St. Clair",
        :city => @detroit
      )
      @st_clair.should be_valid
    end

    describe "invalid cases" do
      before do
        @hotel = Hotel.new # This should be the same since we want it to be invalid
        @hotel.should_not be_valid # Need to call valid so that we'll have errors, if any
      end

      it "should not be valid" do
        lambda {@hotel.save!}.should raise_error(ActiveRecord::RecordInvalid)
      end

      it "should not be valid without a name" do
        @hotel.errors.full_messages.should include("Name can't be blank")
      end

      it "should not be valid with a name shorter than 2 characters" do
        @hotel.errors.full_messages.should include("Name is too short (minimum is 2 characters)")
      end

      it "should have a city" do
        @hotel.errors.full_messages.should include("City can't be blank")
      end
    end
  end

  describe "#yet_to_visit" do
    before do
      @visited_hotel = Factory.create( :hotel, :visited => true )
      @unvisited_hotel = Factory.create( :hotel, :visited => false )
    end

    it "should return visited hotels" do
      Hotel.yet_to_visit.should eq([@unvisited_hotel])
    end
  end
  
end

