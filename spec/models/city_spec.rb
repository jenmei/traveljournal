require 'spec_helper'

describe City do
  it "should have multiple hotels" do
    @city = City.new
    @city.should respond_to(:hotels)
  end
end
