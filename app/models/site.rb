class Site < ActiveRecord::Base
  has_many :pages
  validates_presence_of :sitename
end
