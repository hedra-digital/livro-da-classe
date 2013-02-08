class Collaboration < ActiveRecord::Base

  # Relationships
  belongs_to          :collaborator
  belongs_to          :book

  # Specify fields that can be accessible through mass assignment
  attr_accessible     :book_id, :collaborator_id
end
