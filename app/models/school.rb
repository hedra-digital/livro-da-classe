class School < ActiveRecord::Base
  attr_accessible :name

  has_many :assignments
  has_many :books, through: :assignments
  
end
