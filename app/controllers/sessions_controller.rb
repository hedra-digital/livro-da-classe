# encoding: utf-8

class SessionsController < ApplicationController
  layout 'public'

  def new
  end

  def create
    user = User.find_by_email(params[:signin][:email])
    if user && user.authenticate(params[:signin][:password])
      session[:user_id] = user.id
      redirect_to app_home_path, :notice => 'Usuário autenticado!'
    else
      flash.now.alert = 'Usuário ou senha inválidos'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, :notice => 'Você saiu da área logada.'
  end

end
