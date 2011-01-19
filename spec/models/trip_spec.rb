require 'spec_helper'

describe Trip do
  describe "validation" do
    before do
      @detroit = City.create!(:name => "Detroit")
      @st_clair_hotel = Hotel.create!(:name => "St. Clair Hotel", :city => @detroit)
    end

    it "should be valid with valid attributes" do
      @trip = Trip.new(
        :name => "Visit Shanghai",
        :hotel => @st_clair_hotel
      )
      @trip.should be_valid
    end

    describe "when invalid" do
      before do
        @trip = Trip.new
        @trip.should_not be_valid
      end

      it "should raise an error when receiving #save!" do
        lambda {@trip.save!}.should raise_error(ActiveRecord::RecordInvalid)
      end

      it "should not be valid without a name" do
        @trip.errors.full_messages.should include("Name can't be blank")
      end

      it "should not be valid with a name shorter than 2 characters" do
        @trip.errors.full_messages.should include("Name is too short (minimum is 2 characters)")
      end

      it "should have a hotel" do
        @trip.errors.full_messages.should include("Hotel can't be blank")
      end
    end
  end
end

