class CreateTimelinesTable < ActiveRecord::Migration
  
  extend MigrationHelpers 
  
  def self.up
    create_table :timelines do |t|
      t.column :time_line_id, :bigint, :null => false
      t.column :time_line_created_at, :timestamp, :null => false
      t.column :in_reply_to_status_id, :bigint
      t.column :text,  :string, :null => false
      t.column :source, :string
      t.timestamps
    end
    
    add_index :timelines, :time_line_id, :unique => true
    add_index :timelines, :time_line_created_at
    add_index :timelines, :in_reply_to_status_id
    add_index :timelines, :text
    add_index :timelines, :source
    
  end
  
  def self.down
    drop_table :timelines
  end
  
end
