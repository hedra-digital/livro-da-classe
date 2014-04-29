# encoding: utf-8

class PasswordResetsController < ApplicationController
  before_filter :find_user, :only => [:edit, :update]

  layout :choose_layout

  def new
  end

  def create
    user = User.find_by_email(params[:password_reset][:email])
    user.send_password_reset if user
    redirect_to root_url, :notice => "Email enviado com instruções para recuperar a senha."
  end

  def edit
  end

  def update
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => "A alteração de senha já expirou."
    elsif @user.update_attributes(params[:user])
      # login at once
      session[:auth_token] = @user.auth_token
      redirect_to app_home_path, :notice => "Sua senha foi alterada! Você já pode usar a senha nova."
    else
      render :edit
    end
  end

  private

  def find_user
    @user = User.find_by_password_reset_token!(params[:id])
  end
end
