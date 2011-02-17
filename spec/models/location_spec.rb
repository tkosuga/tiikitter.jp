require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Location do
  
  before(:each) do
  end
  
  it "メソッドを呼ぶだけ" do
    Location.find(:first).sentence
    Sentence.new.location
  end
  
  it "メソッドを呼ぶだけ" do
    p Location.popular_locations(5, 21)
  end

  it "メソッドを呼ぶだけ" do
    p Location.popular_locations(1, 999)
  end

  it "ヒートマップを作るためのプロットを持ったログファイルが作られるか確認。popular" do
    Location.wirte_popular_plot("tmp/spec_test_popular_locations.log")
    File.exists?("tmp/spec_test_popular_locations.log").should be_true
  end
  
end
