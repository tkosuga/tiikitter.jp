require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Tokenizer do
  
  it "北海道の札幌は凄くいい所" do
    tokens = Tokenizer.new.analize("北海道の札幌は凄くいい所")
    tokens.size.should eql 2
    tokens[0].should eql "北海道"
    tokens[1].should eql "札幌"
  end
  
  it "福島県の郡山市っていつもこんな感じ？" do
    tokens = Tokenizer.new.analize("福島県の郡山市っていつもこんな感じ？")
    tokens.size.should eql 2
    tokens[0].should eql "福島"
    tokens[1].should eql "郡山"
  end
  
  it "いま、外から幼女の「いやーん！」という声がきこえた。へいわー。" do
    tokens = Tokenizer.new.analize("いま、外から幼女の「いやーん！」という声がきこえた。へいわー。")
    tokens.size.should eql 0
  end
  
  it "沖縄の多良間はいいところ。" do
    tokens = Tokenizer.new.analize("沖縄の多良間はいいところ。")
    tokens.size.should eql 2
    tokens[0].should eql "沖縄"
    tokens[1].should eql "多良間"
  end
  
  it "今回の高知キャンプオフの総走行距離1200kmくらいやった" do
    tokens = Tokenizer.new.analize("今回の高知キャンプオフの総走行距離1200kmくらいやった")
    tokens.size.should eql 1
    tokens[0].should eql "高知"
  end  
  
  it "ｲﾏｺﾉﾍﾝ! L:東京都世田谷区用賀２丁目" do
    tokens = Tokenizer.new.analize("ｲﾏｺﾉﾍﾝ! L:東京都世田谷区用賀２丁目")
    tokens.size.should eql 3
    tokens[0].should eql "東京"
    tokens[1].should eql "世田谷"
    tokens[2].should eql "用賀"
  end  
  
  it "ｲﾏｺﾉﾍﾝ! L:東京都足立区鹿浜５丁目 [http://tinyurl.com/r5o78w]" do
    tokens = Tokenizer.new.analize("ｲﾏｺﾉﾍﾝ! L:東京都足立区鹿浜５丁目 [http://tinyurl.com/r5o78w]")
    tokens.size.should eql 3
    tokens[0].should eql "東京"
    tokens[1].should eql "足立"
    tokens[2].should eql "鹿浜"
  end
  
  it "久留米が正しく取れる" do
    tokens = Tokenizer.new.analize("久留米が正しく取れない")
    tokens[0].should eql "久留米"
  end
  
  it "首里が正しく取れる" do
    tokens = Tokenizer.new.analize("首里が正しく取れない")
    tokens[0].should eql "首里"
  end
  
  it "1文字の " + %w(中 上 下 右 左 赤 青 緑 大 山 日 森 県 東 西 南 北 光 学).join(", ") + "は無視する" do
    tokens = Tokenizer.new.analize("1文字の" + %w(中 上 下 右 左 赤 青 緑 大 山 日 森 県 東 西 南 北 光 学).join(", ") + "は無視する")
    tokens.should be_empty
  end
  
end
