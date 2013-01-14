# encoding: utf-8

class SessionsController < ApplicationController
  layout 'public'

  def new
  end

  def create
    user = User.find_by_email(params[:signin][:email])
    if user && user.authenticate(params[:signin][:password])
      if params[:signin][:remember_me]
        cookies.permanent[:auth_token] = user.auth_token
      else
        cookies[:auth_token] = user.auth_token
      end
      redirect_to app_home_path, :notice => 'Usuário autenticado!'
    else
      flash.now.alert = 'Usuário ou senha inválidos'
      render :new
    end
  end

  def destroy
    cookies.delete(:auth_token)
    redirect_to root_path, :notice => 'Você saiu da área logada.'
  end

end
