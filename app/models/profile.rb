class Profile < ActiveRecord::Base
  attr_accessible :desc

  validates :desc,              :presence => true
end
