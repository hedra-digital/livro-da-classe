class Invitation < ActiveRecord::Base

  belongs_to           :book
  belongs_to           :user, :foreign_key => 'invited_id'

  attr_accessible      :book_id, :invited_id
end
