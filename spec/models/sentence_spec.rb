require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Sentence do
  
  it "タイムラインからセンテンスを1つ生成する" do
    sentences = genereta_sentences("久留米が正しく取れない")
    sentences.size.should eql 1
    sentences.first.text.should eql "久留米"
    sentences.first.location.should eql Location.find(:first, :conditions => {:name => "久留米"})
  end
  
  it "タイムラインからセンテンスを2つ生成する" do
    sentences = genereta_sentences("首里と久留米")
    sentences.size.should eql 2
    sentences.first.text.should eql "首里"
    sentences.first.location.should eql Location.find(:first, :conditions => {:name => "首里"})
    sentences.second.text.should eql "久留米"
    sentences.second.location.should eql Location.find(:first, :conditions => {:name => "久留米"})
  end
  
  private
  
  def genereta_sentences(text)
    
    timeline = Timeline.new({:time_line_created_at => Date.today, :time_line_id => 1, :text => text})
    timeline.generate_sentences
    timeline.sentences
    
  end
  
end
