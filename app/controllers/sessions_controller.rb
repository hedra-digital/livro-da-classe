# encoding: utf-8

class SessionsController < ApplicationController
  def new
    render :layout => 'public'
  end

  def create
    if params[:signin]
      user = User.find_by_email(params[:signin][:email])
      if user && user.authenticate(params[:signin][:password])
        if params[:signin][:remember_me]
          cookies.permanent[:auth_token] = user.auth_token
        end
        authenticate(user)
      else
        flash.now.alert = 'Usuário ou senha inválidos'
        render :new
      end
    elsif env['omniauth.auth']
      user = User.from_omniauth(env['omniauth.auth'])
      authenticate(user)
    end
  end

  def destroy
    cookies.delete(:auth_token)
    session[:auth_token] = nil
    redirect_to root_path, :notice => 'Você saiu da área logada.'
  end
end
