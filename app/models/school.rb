class School < ActiveRecord::Base

  # Validations
  validates :name, :state, :city, :presence => true

  # Specify fields that can be accessible through mass assignment
  attr_accessible :city, :name, :state

end
