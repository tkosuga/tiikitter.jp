class CreateSentences < ActiveRecord::Migration
  
  extend MigrationHelpers 
  
  def self.up
    create_table :sentences do |t|
      t.column :text, :string, :null => false
      t.timestamps
    end
    
    add_index :sentences, :text, :unique => true
    
  end
  
  def self.down
    drop_table :sentences
  end
  
end
