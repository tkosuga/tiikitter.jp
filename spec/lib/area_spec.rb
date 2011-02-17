require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Area do
  
  it "発言の多かった地域情報を取得します。キャッシュは同じものを返します。" do
    
    Bot.find(:first).update_recent_timelines
    Area.update
    
    result = Area.diagnoses
    result.keys.size.should_not eql 0
    result.should eql Area.cached_diagnoses
    
  end
  
  it "発言の多かった都道府県情報を取得します。キャッシュは同じものを返します。" do
    
    Bot.find(:first).update_recent_timelines
    Area.update
    
    result = Area.japanese_states_diagnoses
    result.keys.size.should_not eql 0
    result.should eql Area.cached_japanese_states_diagnoses
    
  end
  
end
