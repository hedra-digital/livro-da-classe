# == Schema Information
#
# Table name: clients
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  position   :string(255)
#  phone      :string(255)
#  company    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Client < ActiveRecord::Base

  # Relationships
  belongs_to                :user
  has_many                  :projects

  # Delegate
  delegate                  :name, :name=, :email, :email=, :to => :user

  # Validations
  validates :user_id,       :presence => true

  # Specify fields that can be accessible through mass assignment
  attr_accessible           :company, :phone, :position, :user_id, :email, :name
end
