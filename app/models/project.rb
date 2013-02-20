# == Schema Information
#
# Table name: projects
#
#  id           :integer          not null, primary key
#  book_id      :integer
#  release_date :date
#  finish_date  :date
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Project < ActiveRecord::Base

  # Relationships
  belongs_to                :book

  # Validations
  validates :book_id,       :presence => true

  # Specify fields that can be accessible through mass assignment
  attr_accessible           :book_id, :finish_date, :release_date
end
