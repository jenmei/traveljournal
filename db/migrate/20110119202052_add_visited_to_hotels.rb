class AddVisitedToHotels < ActiveRecord::Migration
  def self.up
    add_column :hotels, :visited, :boolean
  end

  def self.down
    remove_column :hotels, :visited
  end
end
