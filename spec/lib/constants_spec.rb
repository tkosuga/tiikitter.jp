require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe StateConstants do
  
  include StateConstants
  
  it "日本の州が含まれている。北海道の札幌は凄くいい所" do
    include_japanese_states?("北海道").should be_true
  end
  
  it "日本の州が含まれている。福島県の郡山市っていつもこんな感じ？" do
    include_japanese_states?("福島").should be_true
  end
  
  it "include_japanese_states? 札幌は凄くいい所" do
    include_japanese_states?("札幌").should be_false
  end
  
  it "include_japanese_states? 郡山市っていつもこんな感じ？" do
    include_japanese_states?("郡山").should be_false
  end
  
  it "駅の名前1" do
    include_station_name?("札幌")
  end
  
  it "駅の名前2" do
    include_station_name?("浅岸")
  end
  
  it "駅の名前3" do
    include_station_name?("阿蘇下田城")
  end
  
  it "駅の名前4" do
    include_station_name?("生野屋")
  end
  
  it "駅の名前5" do
    include_station_name?("伊予和気")
  end
  
  it "駅の名前6" do
    include_station_name?("越後片貝")
  end
  
  
  it "地名1" do
    include_place_name?("札幌")
  end
  
  it "地名2" do
    include_place_name?("浅岸")
  end
  
  it "地名3" do
    include_place_name?("阿蘇下田城")
  end
  
  it "地名4" do
    include_place_name?("生野屋")
  end
  
  it "地名5" do
    include_place_name?("伊予和気")
  end
  
  it "地名6" do
    include_place_name?("越後片貝")
  end
  
  it "地名7" do
    include_place_name?("北設楽")
  end
  it "地名8" do
    include_place_name?("西松浦")
  end
  it "地名9" do
    include_place_name?("豊見城")
  end
  it "地名10" do
    include_place_name?("与那国")
  end
  
end
