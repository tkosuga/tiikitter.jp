class ModifyLatLngs < ActiveRecord::Migration
  
  extend MigrationHelpers 
  
  def self.up
    
    open("data/prefs_latlng.txt"){|f|
      f.readlines.each{|line|
        name, lat, lng  = line.split(",").collect{|token| token.strip}
        if (name.blank? || lat.blank? || lng.blank?)
          next
        end
        model = Location.find(:first, :conditions => {:name => name})
        if (model.blank?)
          puts "warning. Model not found. name=#{name}"
        else
          model.update_attributes(:lat => lat, :lng => lng)
        end
      }
    }
    
  end
  
  def self.down
  end
  
end
