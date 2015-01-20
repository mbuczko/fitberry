ActiveAdmin.register Team do

  scope :all, :default => true

  scope :active do |team|
    team.joins(:challange).where('challanges.active = true')
  end

  scope :past do |team|
    team.joins(:challange).where('challanges.finished = true')
  end

  index do
    column :name do |team|
      link_to team.name, admin_team_path(team)
    end
    column :challange
    default_actions
  end

  show do
    panel "Team Details" do
      attributes_table_for team do
        row("Team name") { team.name }
        row("Taking part in challange") { team.challange[:name] }
        row("Team members") { render "details" }
      end
    end
  end

  filter :name

  form do |f|
    f.inputs "Team Details" do
      f.input :challange, :as => :select
      f.input :name
      f.input :users, :as => :check_boxes, :hint => 'Team members'
    end
    f.actions
  end
end
