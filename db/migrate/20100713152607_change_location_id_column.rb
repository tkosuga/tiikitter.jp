class ChangeLocationIdColumn < ActiveRecord::Migration
  def self.up
    change_column :sentences, :location_id, :bigint
  end

  def self.down
  end
end
