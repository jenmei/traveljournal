require 'spec_helper'

describe "hotels" do
  before do
    @detroit = Factory.create(
      :city,
      :name => "Detroit"
    )
    @hotel1 = Factory.create( :hotel, :name => "The Lakes" )
    @hotel2 = Factory.create( :hotel, :name => "The St. Clair" )
  end

  describe "listing hotels" do
    describe "when the format is html" do
      before do
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
        visit "/hotels.json"
      end

      it "should render the found hotels as json" do
        hotels = JSON.parse(page.body)
        hotels.should be_an(Array)
        hotels.first["hotel"]["name"].should == "The Lakes"
      end
    end
  end

  describe "creating new hotels" do
    before do
      visit "/hotels/new"
    end

    it "should present a form for submitting a new hotel" do
      header = page.find('h1').text
      header.should == "New Hotel"
      page.should have_css('form div label:contains("Name")')
      page.should have_css('form div label:contains("Description")')
      page.should have_css('form div label:contains("City")')
    end

    describe "when filling in a form and submitting" do
      describe "using valid parameters" do
        before do
          fill_in 'Name', :with => "The Lakeside Hotel"
          fill_in 'Description', :with => "A lovely view of Lake St. Clair"
          select "Detroit", :from => 'hotel_city_id'
          click_button "Save"
        end

        it "should display the hotel that we just created" do
          page.find('h1').should have_content('The Lakeside Hotel')
          lakeside_hotel = Hotel.find_by_name("The Lakeside Hotel")
          current_path.should == hotel_path(lakeside_hotel)
        end

        it "should associate the correct city with our hotel" do
          lakeside_hotel = Hotel.find_by_name("The Lakeside Hotel")
          lakeside_hotel.city.should == @detroit
        end
      end

      describe "with invalid parameters" do
        before do
          click_button "Save"
        end

        it "should redisplay the form w/ an error message" do
          page.find('div.error:contains("Name can\'t be blank")')
        end
      end
    end
  end
end
