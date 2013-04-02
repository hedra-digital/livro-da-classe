class Admin::ApplicationController < ActionController::Base
  protect_from_forgery

  http_basic_authenticate_with :name => "frodo", :password => "shire"

  layout 'admin/layouts/application'

end
