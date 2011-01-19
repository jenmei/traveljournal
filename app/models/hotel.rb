class Hotel < ActiveRecord::Base
  validates :name, :presence => true
  validates_length_of :name, :minimum => 2
end

