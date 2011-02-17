class AlterTimeline2 < ActiveRecord::Migration
  
  def self.up
    add_column :timelines, :user_name, :string
    add_index :timelines, :user_name, :unique => false
  end
  
  def self.down
    remove_column :timelines, :user_name
  end
  
end
