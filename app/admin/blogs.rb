ActiveAdmin.register Blog do

  scope :all, :default => true

  scope :published do |blog|
    blog.where('published_at IS NOT NULL')
  end

  scope :not_published do |blog|
    blog.where('published_at IS NULL')
  end

  action_item :only => :show do
    link_to 'Publish', publish_path(blog), :method => :post
  end

  index do
    column :challange
    column :title do |blog|
      link_to blog.title, admin_blog_path(blog)
    end
    column :user
    column :published_at
    default_actions
  end

  show do
    panel "Blog Details" do
      attributes_table_for blog do
        row("Title") { raw("<h3>"+blog.title+"</h3>") }
        row("Description") { raw("<div id='preview'><img src='"+blog.image.url(:original)+"'/>"+(blog.htmlized || "")+"</div>") }
        row("Published at") { status_tag (blog.published_at ? blog.published_at.to_s : "not published yet"), blog.published_at ? :ok : :warning }
      end
    end
  end

  filter :title

  form do |f|
    f.inputs "Blog Details" do
      f.input :challange, :as => :select
      f.input :title, :input_html => { :rows => 5 }, :hint => 'Title of the blog entry'
      f.input :description, :input_html => { :rows => 10 }, :hint => 'Textile markup availble. Look at <a target="blank" href="http://en.wikipedia.org/wiki/Textile_(markup_language)#Formatting_help_table">Textile Wiki</a> for help.'.html_safe
      f.input :user_id, :as => :hidden, :value => current_user.id
    end
    f.inputs "Preview  (drop image to change side picture)", :id => 'preview', :class => 'bottom' do
      f.form_buffers.last << content_tag(:div, blog.image ? image_tag(blog.image.url(:original), :class => "preview") : "", :id => "image")
      f.form_buffers.last << content_tag(:div, "", :id => "text")
      f.form_buffers.last << javascript_include_tag("active_admin_blog.js")
    end
    f.actions

  end
end
