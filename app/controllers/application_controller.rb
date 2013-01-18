class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def current_user
    session['current_user'] ||= User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]
  end

  def authentication_check
    unless  session['current_user'].present?
      redirect_to signin_path
    end
  end

  helper_method :current_user

end
