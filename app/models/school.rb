class School < ActiveRecord::Base
  attr_accessible :name, :book_ids
  has_many :books, :inverse_of => :school
end
