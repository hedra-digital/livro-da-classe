# encoding: utf-8

class PasswordResetsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:password_reset][:email])
    user.send_password_reset if user
    redirect_to root_url, :notice => "Email enviado com instruções para recuperar a senha."
  end
end
