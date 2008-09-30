class Page < ActiveRecord::Base
  has_many :articles
  belongs_to :site
  validates_associated :site
	validates_presence_of :site_id
	validates_presence_of :page_weight
	validates_numericality_of :page_weight
end
