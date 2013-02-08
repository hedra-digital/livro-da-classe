class Collaboration < ActiveRecord::Base

  # Relationships
  belongs_to          :collaborator, :class_name => "User", :foreign_key  => "collaborator_id"
  belongs_to          :book

  # Specify fields that can be accessible through mass assignment
  attr_accessible     :book_id, :collaborator_id
end
