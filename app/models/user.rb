# encoding: utf-8

class User < ActiveRecord::Base
  has_secure_password

  # Validations
  validates :name, :presence => true
  validates :email, :email_format => { :message => 'Não é um formato válido de e-mail', :allow_blank => true }, :uniqueness => true, :presence => true

  # Specify fields that can be accessible through mass assignment
  attr_accessible :email, :name, :password, :password_confirmation, :teacher, :student_count, :school_name

end
