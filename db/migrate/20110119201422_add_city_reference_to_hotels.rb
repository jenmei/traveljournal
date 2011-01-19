class AddCityReferenceToHotels < ActiveRecord::Migration
  def self.up
    add_column :hotels, :city_id, :integer
  end

  def self.down
    remove_column :hotels, :city_id
  end
end
