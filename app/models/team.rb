class Team < ActiveRecord::Base
  attr_accessible :name, :user_ids, :challange_id
  attr_accessor :progress

  validates :name, :presence => true
  after_initialize :init

  default_scope order('distance DESC')

  scope :active, joins(:challange).where("challanges.active=true").readonly(false)
  scope :challanged, lambda{|challange| joins(:challange).where("challanges.id=?", challange.id).readonly(false)}

  belongs_to :challange
  has_many :users

  def init
    self.distance  ||= 0.0
    self.challange ||= Challange.last
  end

  def update_progress
    update_attribute('distance', Activity.teamed_active(self.id).sum("distance"))
  end
end
