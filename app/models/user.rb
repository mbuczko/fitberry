class User < ActiveRecord::Base
  devise :omniauthable, :trackable, :database_authenticatable

  scope :active, joins(:team).joins("INNER JOIN challanges ON teams.challange_id=challanges.id").where("challanges.active=true").readonly(false)

	attr_accessor :agree_risk, :agree_use, :agree_lost

	attr_accessible :provider, :uid,
                  :department, :role, :is_admin,
                  :email, :avatar, :name, :nickname, :town, :gender, :about, :birth,
                  :base_distance, :base_steps, :base_calories,
                  :last_sync_date,
									:agree_risk, :agree_use, :agree_lost


  validates :email, :presence => true, :email => true
  validates :department, :presence => true
  validates :role, :presence => true
  validates :agree_risk, :acceptance => true
  validates :agree_use,  :acceptance => true
  validates :agree_lost, :acceptance => true


  belongs_to :team
  has_many :activities

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.full_name
      user.nickname = auth.info.nickname
      user.gender = auth.info.gender
      user.about = auth.info.about_me
      user.town = auth.info.city
      user.birth = auth.info.dob
      user.avatar = auth.extra.raw_info.user.avatar
      user.oauth_token = auth['credentials']['token']
      user.oauth_secret = auth['credentials']['secret']
    end
  end

  def synchronize_statistics
    if statistics['lifetime']
      Activity.find_or_initialize_by_user(self).update_from_fitbit(statistics['lifetime']['tracker'])
    end
  end

  def synchronize_devices
    devices = client.devices
    update_attribute(:last_sync_date, DateTime.strptime(devices.first['lastSyncTime'], "%Y-%m-%dT%T.%L")) unless devices.blank?
  end

  def statistics
    @activities ||= client.activity_statistics
  end

  def linked?
    oauth_token.present? && oauth_secret.present?
  end

  def admin?
    is_admin
  end

  def rebase(activity)
    update_attributes({:base_distance => base_distance+activity.distance,
                       :base_steps => base_distance+activity.steps,
                       :base_calories => base_distance+activity.calories_out})

    activity.update_attributes({:distance => 0,
                                :steps => 0,
                                :calories_out => 0})
  end

  private

  def client
    raise 'Account is not linked with a Fitbit account' unless linked?

    @client ||= Fitgem::Client.new(
        :consumer_key => FITBIT_CONFIG['consumer_key'],
        :consumer_secret => FITBIT_CONFIG['consumer_secret'],
        :token => oauth_token,
        :secret => oauth_secret,
        :user_id => uid,
        :unit_system => Fitgem::ApiUnitSystem.METRIC)
  end
end
