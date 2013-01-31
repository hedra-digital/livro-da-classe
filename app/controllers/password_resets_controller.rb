# encoding: utf-8

class PasswordResetsController < ApplicationController
  layout :choose_layout

  def new
  end

  def create
    user = User.find_by_email(params[:password_reset][:email])
    user.send_password_reset if user
    redirect_to root_url, :notice => "Email enviado com instruções para recuperar a senha."
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => "A alteração de senha já expirou."
    elsif @user.update_attributes(params[:user])
      redirect_to app_home_path, :notice => "A senha foi alterada!"
    else
      render :edit
    end
  end

  private

  def choose_layout
    current_user ? "application" : "public"
  end
end
