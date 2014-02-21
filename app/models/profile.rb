class Profile < ActiveRecord::Base

  after_commit :create_permissions, :on => :create

  attr_accessible :desc

  validates :desc,              :presence => true

  def create_permissions
    Permission.create_for_profile self
  end
end
