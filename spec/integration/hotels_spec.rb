require 'spec_helper'

describe "hotels" do
  before do
    @hotel1 = Factory.create(
      :hotel, 
      :name => "The Lakes"
    )
    @hotel2 = Factory.create(
      :hotel, 
      :name => "St. Clair Hotel"
    )
  end

  describe "listing hotels" do
    describe "when format is html" do
      before do
        visit "/hotels"
      end

      it "should list as many hotels as we have" do
        page.all('ul li').should have(2).hotels
      end

      it "should list all hotel names (xpath)" do
        page.should have_xpath(
          "//li[.='#{@hotel1.name}']"
        )
        page.should have_xpath(
          "//li[.='#{@hotel2.name}']"
        )
      end

      it "should list all hotel names (css)" do
        hotel_names = page.all('ul li').map(&:text)
        hotel_names.should include(@hotel1.name)
        hotel_names.should include(@hotel2.name)
      end

      describe "when clicking on a link" do
        before do
          click_link(@hotel1.name)
        end

        it "should show detailed information for our hotel" do
          page.should have_xpath(
            "//h1[.='#{@hotel1.name}']"
          )
        end
      end

    end

    describe "when the requested format is xml" do
      before do
        visit "/hotels.xml"
      end

      it "should render the found hotels as xml" do
        page.should have_xpath('//hotels[@type="array"]')
      end
    end

    describe "when the requested format is json" do
      before do
        visit '/hotels.json'
      end

      it "should render the found hotels as json" do
        hotels = JSON.parse(page.body)
        hotels.should be_an(Array)
        hotels.first["hotel"]["name"].should == "St. Clair Hotel"
      end
    end

  end

end

