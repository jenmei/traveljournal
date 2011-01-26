class Trip < ActiveRecord::Base
  validates_presence_of :name
  validates_length_of :name, :minimum => 2

  belongs_to :hotel
  validates_presence_of :hotel
end
