class Template < ActiveRecord::Base

  # Relationships
  has_many                :books

  # Validations
  validates               :name, :presence => true

  # Specify fields that can be accessible through mass assignment
  attr_accessible         :name
end
