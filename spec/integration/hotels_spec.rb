require 'spec_helper'

describe "hotels" do
  describe "listing hotels" do
    before do
      @hotel1 = Factory.create( :hotel, :name => "The Lakes" )
      @hotel2 = Factory.create( :hotel, :name => "The St. Clair" )
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

    describe "when clicking on a link" do
      before do
        click_link('The Lakes')
      end

      it "should show detailed information for our hotel" do
        page.should have_xpath("//h1[.='The Lakes']")
      end
    end
  end

end
