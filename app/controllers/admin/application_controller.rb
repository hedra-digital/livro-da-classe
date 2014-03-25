class Admin::ApplicationController < ActionController::Base
  layout 'admin/layouts/application'

  protect_from_forgery

  http_basic_authenticate_with(:name => CONFIG[:restricted_area][:username], :password => CONFIG[:restricted_area][:password])

  def current_publisher
    publisher = Publisher.where("url LIKE ?", "%#{request.host}%").first
    if publisher.nil?
      session[:publisher] = Publisher.get_default.id
    else
      session[:publisher] = publisher.id
    end
  end
end
