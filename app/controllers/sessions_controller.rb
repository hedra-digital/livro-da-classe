# encoding: utf-8

class SessionsController < ApplicationController
  layout :choose_layout

  def new
    render :layout => 'public'
  end

  def create
    if params[:signin]
      user = User.find_by_email(params[:signin][:email])
      begin
        if user && user.authenticate(params[:signin][:password])
          if params[:signin][:remember_me]
            cookies.permanent[:auth_token] = user.auth_token
          end
          session[:auth_token] = user.auth_token
          redirect_to app_home_path
        else
          flash.now.alert = 'Usuário ou senha inválidos'
          render :new, :layout => 'public'
        end
      rescue #BCrypt::Errors::InvalidHash
        flash.now.alert = 'Usuário ou senha inválidos'
        render :new, :layout => 'public'
      end
    elsif env['omniauth.auth']
      user = User.from_omniauth(env['omniauth.auth'])
      session[:auth_token] = user.auth_token
      redirect_to app_home_path
    end
  end

  def destroy
    cookies.delete(:auth_token)
    session[:auth_token] = nil
    redirect_to root_path, :notice => 'Você saiu da área logada.'
  end
end
