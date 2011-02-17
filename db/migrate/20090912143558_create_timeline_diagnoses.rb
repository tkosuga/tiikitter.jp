class CreateTimelineDiagnoses < ActiveRecord::Migration
  
  extend MigrationHelpers 
  
  def self.up
    create_table :timeline_diagnoses  do |t|
      t.column :sentence_id, :bigint, :null => false
      t.column :timeline_id, :bigint, :null => false
      t.timestamps
    end
    
    foreign_key :timeline_diagnoses, :sentence_id, :sentences
    foreign_key :timeline_diagnoses, :timeline_id, :timelines
    
    add_index :timeline_diagnoses, :sentence_id
    add_index :timeline_diagnoses, :timeline_id
    
  end
  
  def self.down
    drop_table :timeline_diagnoses
  end
  
end
