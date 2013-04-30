class Admin::ApplicationController < ActionController::Base
  layout 'admin/layouts/application'

  protect_from_forgery

  http_basic_authenticate_with(:name => CONFIG[:admin_username], :password => CONFIG[:admin_password])
end
