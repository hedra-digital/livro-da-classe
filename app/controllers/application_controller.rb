# encoding: UTF-8

class ApplicationController < ActionController::Base
  before_filter :log_additional_data

  include AuthorizationHelper

  protect_from_forgery

  http_basic_authenticate_with(:name => CONFIG[:restricted_area][:username], :password => CONFIG[:restricted_area][:password]) if ['sales'].include?(Rails.env)

  helper_method :current_user

  private

  def current_publisher
    publisher = Publisher.where("url LIKE ?", "%#{request.host}%").first
    if publisher.nil?
      session[:publisher] = Publisher.get_default.id
    else
      session[:publisher] = publisher.id
    end
  end

  def current_user
    session[:auth_token] = cookies[:auth_token] if cookies[:auth_token]
    @current_user ||= User.find_by_auth_token(session[:auth_token]) if session[:auth_token]
  end

  def authentication_check
    redirect_to signin_path unless current_user
  end

  def authentication_admin_check
    if !(current_user and current_user.admin?)
      redirect_to signin_path
    end
  end

  def auth_admin_or_publisher
    if !(current_user and (current_user.admin? or current_user.publisher?))
      redirect_to signin_path
    end
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

  def ckeditor_before_create_asset(asset)
    book            = Book.find(session['book_id'])
    asset.assetable = book
    return true
  end

  # run background job
  # https://www.agileplannerapp.com/blog/building-agile-planner/rails-background-jobs-in-threads
  def background(&block)
    Thread.new do
      yield
      ActiveRecord::Base.connection.close
    end
  end

  protected

  def log_additional_data
    request.env["exception_notifier.exception_data"] = {
      :impersonate_link => "http://#{Livrodaclasse::Application.config.action_mailer.default_url_options[:host]}/admin?impersonate_user_id=#{current_user.id}"
    } if !current_user.nil?
  end
end
