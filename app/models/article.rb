class Article < ActiveRecord::Base
  belongs_to :page
  validates_associated :page
	validates_presence_of :page_id
	validates_presence_of :article_weight
	validates_numericality_of :article_weight
	
	acts_as_textiled :article_public_text
	acts_as_textiled :article_private_text  
end
