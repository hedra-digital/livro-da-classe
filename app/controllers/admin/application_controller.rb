class Admin::ApplicationController < ActionController::Base
  layout 'admin/layouts/application'

  protect_from_forgery

  http_basic_authenticate_with(:name => CONFIG[:restricted_area][:username], :password => CONFIG[:restricted_area][:password])
end
