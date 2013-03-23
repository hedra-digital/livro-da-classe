# encoding: UTF-8

class Admin < ActiveRecord::Base

  # Use built-in rails support for password protection
  has_secure_password

  # Validations
  validates :email,         :email_format => { :message => 'Não é um formato válido de e-mail', :allow_blank => true },
                            :uniqueness => true,
                            :presence => true
  validates :password,      :presence => true, :on => :create

  # Specify fields that can be accessible through mass assignment
  attr_accessible           :email, :password, :password_confirmation

end
