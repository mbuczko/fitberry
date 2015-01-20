class Milestone < ActiveRecord::Base
  attr_accessible :name, :latitude, :longitude, :distance, :number, :challange_id
  attr_accessor :progress

  acts_as_gmappable
  validates :distance, :presence => true

  belongs_to :challange

  def gmaps4rails_address
    self.name
  end

  def gmaps4rails_title
    "Milestone: #{self.name} (#{self.distance} km)"
  end

  def gmaps4rails_marker_picture
    {
        :picture => 'http://labs.google.com/ridefinder/images/mm_20_red.png',
        :width   => 20,
        :height  => 20,
    }
  end
end
