class School < ActiveRecord::Base
  attr_accessible :name, :book_ids, :address_1, :address_2, :state, :city, :postal_code
  has_many :books, :inverse_of => :school
end