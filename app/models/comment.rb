class Comment < ActiveRecord::Base
  attr_accessible :blog_id, :body, :user_id
  before_save :htmlize

  default_scope order('created_at ASC')
  scope :current, lambda{|blog_id| where('blog_id=?', blog_id)}

  belongs_to :user
  belongs_to :blog

  def htmlize
    self.htmlized = RedCloth.new(html_escape(self.body)).to_html.gsub(/\n/, '')
  end

end
