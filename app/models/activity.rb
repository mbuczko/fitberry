class Activity < ActiveRecord::Base
  attr_accessible :user, :challange, :distance, :steps, :calories_out

  belongs_to :user
  belongs_to :challange

  scope :teamed, lambda { |team_id| joins(:challange).joins(:user).where("users.team_id=?", team_id) }
  scope :teamed_active, lambda { |team_id| teamed(team_id).where("challanges.active=true") }
  scope :active, joins(:challange).where("challanges.active=true").order("distance DESC").readonly(false)
  scope :challanged, lambda{|challange| joins(:challange).where("challanges.id=?", challange.id).order("distance DESC").readonly(false) }

  def self.find_or_initialize_by_user(user)
    if (record = active.where(:user_id => user.id).first).nil?
      record = new(:user => user, :challange => Challange.active.first)
    end
    return record
  end

  def update_from_fitbit(fb_data)
    update_attributes(:calories_out => (fb_data['caloriesOut'] - user.base_calories),
                      :distance => (fb_data['distance'] - user.base_distance).round(2),
                      :steps => (fb_data['steps'] - user.base_steps))
  end
end
