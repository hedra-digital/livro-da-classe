class User < ActiveRecord::Base
  has_secure_password

  # Validations
  validates :email, :name, :presence => true

  # Specify fields that can be accessible through mass assignment
  attr_accessible :email, :name, :password, :password_confirmation, :teacher, :student_count, :school_name

end
