 # encoding: UTF-8

class ApplicationController < ActionController::Base
  include AuthorizationHelper
  protect_from_forgery

  helper_method :current_user

  private

  def current_user
    session[:auth_token] = cookies[:auth_token] if cookies[:auth_token]
    @current_user ||= User.find_by_auth_token(session[:auth_token]) if session[:auth_token]
  end

  def authentication_check
    redirect_to signin_path unless current_user
  end

  def ominiauth_user_gate
    if current_user && current_user.email.blank? && current_user.asked_for_email.nil?
      current_user.update_attribute(:asked_for_email, true)
      redirect_to email_users_path
    else
      return true
    end
  end

  def choose_layout
    current_user ? "application" : "public"
  end

end
