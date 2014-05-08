class Admin::ApplicationController < ApplicationController
  layout 'admin/layouts/application'

  protect_from_forgery

  before_filter :authentication_admin_check

  def current_publisher
    publisher = Publisher.where("url LIKE ?", "%#{request.host}%").first
    if publisher.nil?
      session[:publisher] = Publisher.get_default.id
    else
      session[:publisher] = publisher.id
    end
  end
end
