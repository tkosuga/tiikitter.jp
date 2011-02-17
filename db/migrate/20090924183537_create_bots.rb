class CreateBots < ActiveRecord::Migration
  
  extend MigrationHelpers 
  
  def self.up
    
    create_table :bots  do |t|
      t.column :name, :string, :null => false
      t.column :email, :string, :null => false
      t.column :password, :string, :null => false
      t.timestamps
    end
    
    Bot.new(:name => "地域ッター西日本", :email => "tkosug.a@gmail.com", :password => "SFSa9ghD").save!
    Bot.new(:name => "地域ッター東日本", :email => "tkosu.ga@gmail.com", :password => "5o15YcCr").save!
    
  end
  
  def self.down
    drop_table :bots
  end
  
end
