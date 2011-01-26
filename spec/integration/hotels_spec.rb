require 'spec_helper'

describe "hotels" do
  describe "listing hotels" do
    before do
      @hotel1 = Hotel.create( :name => "The Lakes" )
      @hotel2 = Hotel.create( :name => "The St. Clair" )
      visit "/hotels"
    end

    it "should list as many hotels as we have" do
      page.all('ul li').should have(2).hotels
    end

    it "should list all hotel names (xpath)" do
      page.should have_xpath("//li[.='The Lakes']")
      page.should have_xpath("//li[.='The St. Clair']")
    end

    it "should list all hotel names (css)" do
      hotel_names = page.all('ul li').map(&:text)
      hotel_names.should include('The Lakes')
      hotel_names.should include('The St. Clair')
    end
  end
end
