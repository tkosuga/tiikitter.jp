class SentenceHasLocation < ActiveRecord::Migration
  
  extend MigrationHelpers 
  
  def self.up
    
    add_column :sentences, :location_id, :integer
    
    Sentence.find(:all).each{|sentence|
      
      location = Location.find(:first, :conditions => ["name = ?", sentence.text])
      if (location.blank?)
        puts "ID=#{sentence.id}, text=#{sentence.text}"
        # sentence.destory
        next
      end
      
      sentence.location = location
      sentence.save!
    }
    
    foreign_key :sentences, :location_id, :locations
    add_index :sentences, :location_id, :unique => true
    
  end
  
  def self.down
    ActiveRecord::IrreversibleMigration
  end
  
end
