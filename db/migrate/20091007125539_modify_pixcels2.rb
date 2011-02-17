class ModifyPixcels2 < ActiveRecord::Migration
  
  extend MigrationHelpers 
  
  def self.up
    
    open("data/pixcels2.txt"){|f|
      f.readlines.each{|line|
        name, x, y  = line.split(",").collect{|token| token.strip}
        if (name.blank? || x.blank? || y.blank?)
          next
        end
        model = Location.find(:first, :conditions => {:name => name})
        if (model.blank?)
          puts "warning. Model not found. name=#{name}"
          next
        end
        puts "#{name}, #{x}, #{y}"
        model.update_attributes!(:x => x, :y => y)
        
        model = Location.find(:first, :conditions => {:name => name})
        raise "????" if (model.x == 0)
      }
    }
    
  end
  
  def self.down
  end
  
end
