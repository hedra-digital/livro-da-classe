# encoding: UTF-8

class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def current_user
    session[:auth_token] = cookies[:auth_token] if cookies[:auth_token]
    @current_user ||= User.find_by_auth_token(session[:auth_token]) if session[:auth_token]
  end

  def authentication_check
    redirect_to signin_path unless current_user
  end

  def authenticate(user)
    session[:auth_token] = user.auth_token
    redirect_to app_home_path, :notice => 'Usuário autenticado!'
  end

  helper_method :current_user

end
