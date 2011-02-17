require 'memcache'
require 'singleton'

class CacheServer
  
  include Singleton
  
  def initialize
    
    memcache_options = {
      :c_threshold => 10_000,
      :compression => true,
      :debug => false,
      :namespace => 'tiikitter',
      :readonly => false,
      :urlencode => false
    }
    
    @cache = MemCache.new memcache_options
    @cache.servers = 'localhost:11211'
  end
  
  #
  # 600秒間キャッシュします
  #
  def put(key, content, expired = 600)
    @cache.set(key.hash.to_s, content, expired)
  end
  
  #
  # キャッシュを返します
  #
  def get(key)
    @cache[key.hash.to_s]
  end
  
end
