require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Timeline do
  
  before(:each) do
    @basic_attributes = {:time_line_created_at => Date.today, :time_line_id => 1}
  end
  
  it "沖縄の多良間はいいところ。" do
    
    timeline = Timeline.new(@basic_attributes.merge(:text => "沖縄の多良間はいいところ。"))
    timeline.generate_sentences
    timeline.sentences.size.should eql 2
    
    timeline.sentences[0].text.should eql "沖縄"
    timeline.sentences[1].text.should eql "多良間"
    
  end
  
  it "今回の高知キャンプオフの総走行距離1200kmくらいやった" do
    
    timeline = Timeline.new(@basic_attributes.merge(:text => "今回の高知キャンプオフの総走行距離1200kmくらいやった"))
    timeline.generate_sentences
    timeline.sentences.size.should eql 1
    
    timeline.sentences[0].text.should eql "高知"
    
  end  
  
  it "ｲﾏｺﾉﾍﾝ! L:東京都世田谷区用賀２丁目" do
    
    timeline = Timeline.new(@basic_attributes.merge(:text => "ｲﾏｺﾉﾍﾝ! L:東京都世田谷区用賀２丁目"))
    timeline.generate_sentences
    timeline.sentences.size.should eql 3
    
    timeline.sentences[0].text.should eql "東京"
    timeline.sentences[1].text.should eql "世田谷"
    timeline.sentences[2].text.should eql "用賀"
  end  
  
  it "ｲﾏｺﾉﾍﾝ! L:東京都足立区鹿浜５丁目 [http://tinyurl.com/r5o78w]" do
    
    timeline = Timeline.new(@basic_attributes.merge(:text => "ｲﾏｺﾉﾍﾝ! L:東京都足立区鹿浜５丁目 [http://tinyurl.com/r5o78w]"))
    timeline.generate_sentences
    timeline.sentences.size.should eql 3
    
    timeline.sentences[0].text.should eql "東京"
    timeline.sentences[1].text.should eql "足立"
    timeline.sentences[2].text.should eql "鹿浜"
  end
  
  it "久留米が正しく取れない" do
    
    timeline = Timeline.new(@basic_attributes.merge(:text => "久留米が正しく取れない"))
    timeline.generate_sentences
    timeline.sentences.size.should eql 1
    
    timeline.sentences[0].text.should eql "久留米"
  end
  
  it "首里が正しく取れない" do
    
    timeline = Timeline.new(@basic_attributes.merge(:text => "首里が正しく取れない"))
    timeline.generate_sentences
    timeline.sentences.size.should eql 1
    
    timeline.sentences[0].text.should eql "首里"
  end
  
  it "1文字の " + %w(中 上 下 右 左 赤 青 緑 大 山 日 森 県 東 西 南 北 光 学).join(", ") + "は無視する" do
    
    timeline = Timeline.new(@basic_attributes.merge(:text => "1文字の" + %w(中 上 下 右 左 赤 青 緑 大 山 日 森 県 東 西 南 北 光 学).join(", ") + "は無視する"))
    timeline.generate_sentences
    timeline.sentences.should be_empty
    
  end
  
  it "検索1" do
    
    timeline = Timeline.new(@basic_attributes.merge(:text => "ｲﾏｺﾉﾍﾝ! L:東京都足立区鹿浜５丁目 [http://tinyurl.com/r5o78w]"))
    timeline.generate_sentences
    
    timelines = Timeline.query("東京")
    timelines.size.should eql 1
    
    timelines.first.should eql timeline
    
  end
  
  after(:each) do
    TimelineDiagnosis.destroy_all
    Sentence.destroy_all
    Timeline.destroy_all
  end
  
end
