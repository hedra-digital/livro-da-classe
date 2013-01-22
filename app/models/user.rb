# encoding: utf-8

class User < ActiveRecord::Base
  has_secure_password

  # Callbacks
  before_create       { generate_token(:auth_token) }

  # Validations
  validates           :name, :presence => true
  validates           :email, :email_format => { :message => 'Não é um formato válido de e-mail', :allow_blank => true }, :uniqueness => true, :presence => true
  validates           :password, :presence => true, :on => :create

  # Specify fields that can be accessible through mass assignment
  attr_accessible     :email, :name, :password, :password_confirmation, :educator, :student_count, :school_name

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def self.from_omniauth(auth)
    where(auth.slice('provider', 'uid')).first || create_from_omniauth(auth)
  end

  def self.create_from_omniauth(auth)
    new_user = self.new do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.name = auth['info']['name']
    end
    new_user.save!(:validate => false)
    new_user
  end
end
