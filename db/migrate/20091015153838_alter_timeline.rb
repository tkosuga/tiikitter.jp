class AlterTimeline < ActiveRecord::Migration
  
  def self.up
    add_column :timelines, :profile_image_uri, :string
    add_index :timelines, :profile_image_uri, :unique => false
  end
  
  def self.down
    remove_column :timelines, :profile_image_uri
  end
  
end
