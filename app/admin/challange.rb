ActiveAdmin.register Challange do
  actions :all, :except => [:destroy]

  scope :all, :default => true

  scope :finished do |challange|
    challange.where(:finished => true)
  end

  scope :active do |challange|
    challange.where(:active => true)
  end

  action_item :only => :show do
    link_to 'Add milestone', new_milestone_path(:challange_id => challange), :remote => true
  end

  action_item :only => :show do
    link_to 'Activate', activate_path(challange), :class => 'fragile', :method => :post
  end

  action_item :only => :show do
    link_to 'Rebase', rebase_path(challange), :class => 'fragile', :method => :post
  end

  index do
    column :name
    column :title do |challange|
      link_to challange.title, admin_challange_path(challange), :class => challange.active ? "active" : ""
    end
    column :description
    column :distance_steps
    column :distance_km
    default_actions
  end

  show do
    panel "Challange Details" do
      attributes_table_for challange do
        row("Status") { status_tag (challange.active ? "active" : "inactive"), challange.active ? :warning : :ok }
        row("Title") { challange.title }
        row("Description") { raw(challange.htmlized) }
        row("Deadline") { challange.deadline }
        row("Starting place") { challange.origin }
        row("Distance (km)") { challange.distance_km }
        row("Distance (steps)") { challange.distance_steps }
        row("Money converter per 1km") { challange.converter }
      end
    end
    panel "Milestones" do
      render "details"
    end
  end

  filter :title

  form do |f|
    f.inputs "User Details" do
      f.input :name, :hint => 'Name to identify challange'
      f.input :title, :input_html => { :rows => 5 }, :hint => 'Title of the challange'
      f.input :deadline, :hint => 'When the challange ends'
      f.input :origin, :hint => 'Starting place'
      f.input :distance_km, :hint => 'Estimated distance (km)'
      f.input :distance_steps, :hint => 'Estimated distance (steps)'
      f.input :description, :as => :text, :input_html => { :rows => 10 }, :hint => 'Textile markup availble. Look at <a target="blank" href="http://en.wikipedia.org/wiki/Textile_(markup_language)#Formatting_help_table">Textile Wiki</a> for help.'.html_safe
      f.input :converter, :hint => 'Money conversion per 1km'

		end
    f.actions
  end

end
