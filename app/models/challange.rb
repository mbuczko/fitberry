class Challange < ActiveRecord::Base
	before_save :htmlize
	attr_accessible :name, :title, :description, :deadline, :active, :origin, :finished, :distance_steps, :distance_km, :converter
  attr_accessor :money

  has_many :milestones, :order => :number

  scope :past, where(:finished => true).order("created_at DESC")
  scope :active, where(:active => true)

	def htmlize
		self.htmlized = RedCloth.new(self.description).to_html.gsub(/\n/, '')
	end

end
