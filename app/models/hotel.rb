class Hotel < ActiveRecord::Base
  validates :name, :presence => true
  validates_length_of :name, :minimum => 2
  belongs_to :city

  def self.yet_to_visit
    where(:visited => false)
  end
  
end

