require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe GoogleMap::HeatMap do
  
  it "x, y initialization 1" do
    dot = GoogleMap::HeatMap::Dot.new("9,7")
    dot.x.should eql 9.0
    dot.y.should eql 7.0
  end
  
  it "x, y initialization 2" do
    dot = GoogleMap::HeatMap::Dot.new("9, 7")
    dot.x.should eql 9.0
    dot.y.should eql 7.0
  end
  
  it "hashとeql?を再定義。hash 1" do
    dot = GoogleMap::HeatMap::Dot.new("9, 7")
    dot.hash.should eql 31827
  end
  
  it "hashとeql?を再定義。hash 2" do
    dot = GoogleMap::HeatMap::Dot.new("9, 8")
    dot.hash.should eql 31828
  end
  
  it "hashとeql?を再定義。hash 3" do
    dot = GoogleMap::HeatMap::Dot.new("8, 9")
    dot.hash.should eql 31792
  end
  
  it "hashとeql?を再定義。eql? 1" do
    dot = GoogleMap::HeatMap::Dot.new("9, 7")
    other = GoogleMap::HeatMap::Dot.new("9, 7")
    dot.eql?(other).should be_true
  end
  
  it "hashとeql?を再定義。eql? 2" do
    dot = GoogleMap::HeatMap::Dot.new("9, 7")
    other = GoogleMap::HeatMap::Dot.new("9, 8")
    dot.eql?(other).should be_false
  end
  
  it "hashとeql?を再定義。eql? 2" do
    dot = GoogleMap::HeatMap::Dot.new("9, 7")
    other = GoogleMap::HeatMap::Dot.new("9, 8")
    dot.eql?(other).should be_false
  end
  
  it "center_x" do
    dot = GoogleMap::HeatMap::Dot.new("100, 50")
    dot.center_x.should eql 68.0
  end
  
  it "center_y" do
    dot = GoogleMap::HeatMap::Dot.new("100, 50")
    dot.center_y.should eql 12.0
  end
  
  it "opacity 1" do
    dot = GoogleMap::HeatMap::Dot.new("100, 50")
    dot.count = 50
    dot.opacity(100).should be_close(127.5, 0.1)
  end
  
  it "opacity 2" do
    dot = GoogleMap::HeatMap::Dot.new("100, 50")
    dot.count = 100
    dot.opacity(255).should be_close(155.0, 0.1)
  end
  
  it "opacity 3" do
    dot = GoogleMap::HeatMap::Dot.new("100, 50")
    dot.count = 1
    dot.opacity(255).should be_close(254.0, 0.1)
  end
  
  it "parse_lines。同じものは1つにまとめられる。" do
    lines = ["100, 50", "100, 50", "100, 50", "100, 50", "100, 50"]
    dots = GoogleMap::HeatMap::Dot.parse_lines(lines)
    dots.size.should eql 1
    dots.first.count.should eql 5
  end  
  
  it "parse_lines。異なるものはまとめられない。" do
    lines = ["100, 50", "100, 51", "100, 52", "100, 53", "100, 54"]
    dots = GoogleMap::HeatMap::Dot.parse_lines(lines)
    dots.size.should eql 5
    dots.first.count.should eql 1
  end  
  
  it "transformed y 1" do
    dot = GoogleMap::HeatMap::Dot.new("100, 200")
    dot.center_y.should be_close(163.0, 0.1)
  end
  
  it "transformed y 2" do
    dot = GoogleMap::HeatMap::Dot.new("100, 350")
    dot.center_y.should be_close(311.0, 0.1)
  end
  
  it "transformed y 3" do
    dot = GoogleMap::HeatMap::Dot.new("100, 550")
    dot.center_y.should be_close(526.0, 0.1)
  end
  
end
