class AlterTimeline3 < ActiveRecord::Migration
  
  def self.up
    add_column :timelines, :user_screen_name, :string
    add_index :timelines, :user_screen_name, :unique => false
  end
  
  def self.down
    remove_column :timelines, :user_screen_name
  end
  
end
