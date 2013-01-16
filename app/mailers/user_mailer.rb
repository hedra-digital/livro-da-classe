# encoding: utf-8

class UserMailer < ActionMailer::Base
  default from: "nao-responda@livrodaclasse.com.br"

  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "Recuperação de senha"
  end
end
