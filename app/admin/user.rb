ActiveAdmin.register User do

  scope :all, :default => true

  scope :poznan do |user|
    user.where('town like ?', '%Poznań%')
  end

  scope :warszawa do |user|
    user.where('town like ?', '%Warszawa%')
  end

  index do
    column :name do |user|
      link_to user.name, admin_user_path(user)
    end
    column :email
    column :team
    column :town
    column :last_sync_date
    default_actions
  end

  show do
    panel "User's Details" do
      attributes_table_for user do
        row("Photo") { image_tag user.avatar }
        row("Nick name") { user.nickname }
        row("Town") { user.town }
        row("Email") { user.email }
        row("About") { user.about }
        row("Department") { user.department }
        row("Role") { user.role }
      end
    end
  end

  filter :email

  sidebar "Member of", :only => :show do
    attributes_table_for user do
      row("Teams") { user.team }
    end
  end

  sidebar "Distance for current challange", :only => :show do
    attributes_table_for user do
      activity = user.activities.active.first
      if activity
        row("Distance") { activity.distance.to_s + " km"}
        row("Steps") { activity.steps.to_s}
      end
      row("Last synchronization") { user.last_sync_date.nil? ? "not available" : user.last_sync_date }
    end
  end

  form do |f|                         
    f.inputs "User Details" do
      f.input :name
      f.input :email
      f.input :department, :as => :select, :collection => ["IT", "HR", "ADMD", "non-ADMD"], :required => true
      f.input :role, :as => :select, :collection => ["Manager", "Specialist", "Other"], :required => true, :label => "Role"
			f.input :is_admin
		end
    f.actions                         
  end                                 
end                                   
