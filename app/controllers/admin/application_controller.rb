class Admin::ApplicationController < ActionController::Base
  protect_from_forgery

  http_basic_authenticate_with :name => CONFIG[:admin_username], :password => CONFIG[:admin_password]

  layout 'admin/layouts/application'

end
