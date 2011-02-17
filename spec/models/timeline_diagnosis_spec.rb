require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TimelineDiagnosis do
  
  before(:all) do
    #
    # 今日のデータです
    #
    timeline = Timeline.new({:time_line_created_at => Date.today, :time_line_id => 1, :text => "東京と札幌"})
    timeline.generate_sentences
    #
    # 1年前のデータとします
    #
    timeline = Timeline.new({:time_line_created_at => Date.today - 1.year, :time_line_id => 2, :text => "東京と札幌"})
    timeline.generate_sentences
    timeline.timeline_diagnoses.each{|timeline_diagnose|
      timeline_diagnose.update_attributes(:created_at => Date.today - 1.year, :updated_at => Date.today - 1.year)
    }
  end
  
  it "センテンスの出現回数を返します" do
    
    sentence_counts = TimelineDiagnosis.sentence_counts
    sentence_counts.values.should eql [2, 2]
    sentence_counts.keys.should have(2).items
    
  end
  
  it "勢いのあるセンテンスの出現回数を返します" do
    
    sentence_counts = TimelineDiagnosis.growing_sentence_counts
    sentence_counts.values.should eql [1, 1]
    sentence_counts.keys.should have(2).items
    
  end  
  
  after(:all) do
    TimelineDiagnosis.destroy_all
    Sentence.destroy_all
    Timeline.destroy_all
  end
  
end
