class ChallangesController < ApplicationController
  before_filter :check_access, :except => :show

  def activate
    active = Challange.find(params[:id])
    current = Challange.active.first

    if current
      current.update_attributes({:active => false, :finished => true})
    end

    active.update_attributes(:active => true)

    # create empty activities for users who didn't synchronized their fitbits yet
    User.active.each {|user| Activity.create(:user => user, :challange => active) if user.activities.empty?}

    redirect_to admin_challanges_path
  end

  # rebase users' steps, distances and calories
  # that means, current values become a 'base' which decreases forthcoming results

  def rebase
    active = Challange.find(params[:id])

    User.active.each do |user|
      activity = user.activities.active.first

      # reset users activities moving old values to the base
      if activity && activity.challange == active
        user.rebase(activity)
      end

      # reset teams aggregated distance
      Team.challanged(active).each{|team| team.update_attribute(:distance, 0)}
    end
    redirect_to admin_challanges_path
  end

end
