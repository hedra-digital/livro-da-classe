class User < ActiveRecord::Base
  has_secure_password

  # Relationships
  belongs_to :school

  # Validations
  validates :email, :name, :presence => true

  # Specify fields that can be accessible through mass assignment
  attr_accessible :email, :name, :password_digest, :password, :password_confirmation

end
