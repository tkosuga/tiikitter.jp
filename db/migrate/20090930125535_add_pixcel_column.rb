class AddPixcelColumn < ActiveRecord::Migration
  
  extend MigrationHelpers 
  
  def self.up
    
    add_column :locations, :x, :integer, :null => false, :default => 0
    add_column :locations, :y, :integer, :null => false, :default => 0
    add_index :locations, :x
    add_index :locations, :y
    
  end
  
  def self.down
    remove_column :locations, :x
    remove_column :locations, :y
  end
  
end
