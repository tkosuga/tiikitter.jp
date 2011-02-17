class Bot < ActiveRecord::Base
  
  include ErrorHelper
  
  #
  # 全てのbotのrefollowを行ないます。
  #
  def self.refollow_all
    find(:all).each{|bot| 
      bot.refollow
    }
  end
  
  #
  # twitterクライアントを返します。
  #
  def twitter_client
    oauth = Twitter::OAuth.new('ca5rRZ3DI60lGfQqTbpsw', '6BR9sRGkxui0T5tGCdxsUoRMtUMSKIItmv8SV3EkY')
    oauth.authorize_from_access(token, secret)
    Twitter::Base.new(oauth)
  end
  
  #
  # フォロー返しを行ないます。
  # フォローされているidをフォローしていない場合には、そのidをフォローします。
  #
  def refollow
    
    client = twitter_client
     (client.follower_ids - client.friend_ids).each{|id| 
      yield_with_logging{
        logger.info("#{name} new following id: #{id}. #{Time.now}")
        client.friendship_create(id)
      }
    }
  end
  
  #
  # タイムラインを生成します
  #
  def self.update_recent_timelines_all
    find(:all).each{|bot|
      bot.update_recent_timelines
    }
  end  
  
  #
  # 指定したオプションを付与しタイムラインを200件取得し、
  # 指定したブロックで取得したタイムラインを1件づつ処理します。
  #
  def update_recent_timelines
    option = {
      :since_id => Timeline.since_id, 
      :count    => 200
    }
    twitter_client.friends_timeline(option).each{|data|
      Timeline.generate_timeline(data)
    }
  end
  
end
