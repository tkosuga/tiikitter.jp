class AddBotColumns < ActiveRecord::Migration
  
  def self.up
    add_column :bots, :token, :string
    add_column :bots, :secret, :string
    
    bot = Bot.find(:first, :conditions => {:name => "地域ッター西日本"})
    bot.update_attributes(:token => "76264861-GHp4PtPioBmPp90vxjBc6jMSkdyWSP6CnZgir1f3B", :secret => "YzqOuvczOosvv59K9ut9umYSH9hnGLU9tl0WQYDCum4")

    bot = Bot.find(:first, :conditions => {:name => "地域ッター東日本"})
    bot.update_attributes(:token => "76265048-QjwVJGqjlylbLm8GXzG84RZaBmb9HdxwEf3hkdxUW", :secret => "a0n8NTIoJMIFfCPPDL8geztlSRv6PT57gvajWSSo")
  end
  
  def self.down
    remove_column :bots, :token
    remove_column :bots, :secret
  end
end
