class CreateLocations < ActiveRecord::Migration
  
  extend MigrationHelpers 
  
  def self.up
    
    create_table :locations  do |t|
      t.column :name, :string, :null => false, :limit => 64
      t.column :lat, :float, :null => false
      t.column :lng, :float, :null => false
      t.timestamps
    end
    
    add_index :locations, :name, :unique => true
    add_index :locations, :lat
    add_index :locations, :lng
    
    open("data/locations.txt"){|f|
      f.readlines.each{|line|
        name, lat, lng  = line.split(",").collect{|token| token.strip}
        if (name.blank? || lng.blank? || lat.blank?)
          next
        end
        Location.new(:name => name, :lng => lng, :lat => lat).save!
      }
    }
    
  end
  
  def self.down
    drop_table :locations
  end
  
end
