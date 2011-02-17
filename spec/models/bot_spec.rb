require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Bot do
  
  it "botは2体います" do
    Bot.find(:all).size.should eql 2
  end
  
  it "フォロー返しを行ないます" do
    Bot.find(:first).refollow
  end
  
  it "全ボットのフォロー返しを行ないます" do
    Bot.refollow_all
  end
  
  it "タイムラインを取得します" do
    Bot.find(:first).update_recent_timelines
  end
  
  it "全ボットのタイムラインを取得します" do
    
    Timeline.since_id.should eql 1
    Bot.update_recent_timelines_all
    Timeline.since_id.should_not eql 1
    
  end  
  
  it "Create Nre Access Token and Access Secret" do
    
    oauth = Twitter::OAuth.new('ca5rRZ3DI60lGfQqTbpsw', '6BR9sRGkxui0T5tGCdxsUoRMtUMSKIItmv8SV3EkY')
    request_token = oauth.request_token
    
    puts "request token: #{request_token.token}"
    puts "request secret: #{request_token.secret}"
    puts "authorize url: #{request_token.authorize_url}"
    
    oauth.authorize_from_request("12R4qArwmB76WmFGY8kKMevEnHCnpWiYe05vhTYRs", "gT9d1wt6nWnRYHO47TsksDTZ2WVV4NsSt7VarOSomg", 1821818)
    
    at = oauth.access_token
    
    puts "access token: #{at.token}"
    puts "access secret: #{at.secret}"
    
  end
  
end
