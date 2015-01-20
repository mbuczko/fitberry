class Blog < ActiveRecord::Base
  attr_accessible :title, :description, :htmlized, :user_id, :challange_id, :published_at, :image
  attr_accessor :has_next, :has_prev

  after_initialize :init

  has_attached_file :image,
                    :path => ":rails_root/public/:attachment/:id/:style/:filename",
                    :url => "/:attachment/:id/:style/:filename"

  belongs_to :user
  belongs_to :challange

  default_scope order('published_at DESC')
  scope :recent, lambda { |challange| where('published_at IS NOT NULL and challange_id=?', challange.id).order('published_at DESC').limit(3) }

  validates :title, :presence => true
  before_save :htmlize

  def init
    self.challange ||= Challange.last
  end

  private

  def htmlize
    self.htmlized = RedCloth.new(self.description).to_html
  end

end
