# == Schema Information
#
# Table name: invitations
#
#  id         :integer          not null, primary key
#  invited_id :integer
#  book_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Invitation < ActiveRecord::Base

  belongs_to           :book
  belongs_to           :user, :foreign_key => 'invited_id'

  attr_accessible      :book_id, :invited_id
end
