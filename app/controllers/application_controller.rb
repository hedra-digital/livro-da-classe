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

  helper_method :current_user

end
