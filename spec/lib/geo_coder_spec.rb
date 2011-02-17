require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe GoogleMap::GeoCoder do
  
  it "move_lng_by_pixel 1" do
    coder = GoogleMap::GeoCoder.new
    coder.move_lng_by_pixel(130.72, 1, 3).should be_close(130.895780995488, 0.01)
  end
  
  it "move_lng_by_pixel 1" do
    coder = GoogleMap::GeoCoder.new
    coder.lng_to_pixel(130.72, 131.72, 3).should eql -6
  end
  
  it "lng_to_x 1" do
    coder = GoogleMap::GeoCoder.new
    coder.lng_to_x(130.72).should eql 463379249
  end
  
  it "move_lat_by_pixel 1" do
    coder = GoogleMap::GeoCoder.new
    coder.move_lat_by_pixel(37.31, 1, 3).should be_close(37.1700595536796, 0.01)
  end
  
  it "move_lat_by_pixel 1" do
    coder = GoogleMap::GeoCoder.new
    coder.lat_to_pixel(38.31, 37.31, 3).should eql 8
  end
  
  it "lat_to_x 1" do
    coder = GoogleMap::GeoCoder.new
    coder.lat_to_y(37.31).should eql 208386247
  end
  
end
