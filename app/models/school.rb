class School < ActiveRecord::Base
  attr_accessible :name
  has_many :books, :inverse_of => :school
end
