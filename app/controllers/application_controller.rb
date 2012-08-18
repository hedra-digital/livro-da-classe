class ApplicationController < ActionController::Base
  protect_from_forgery

  private
    def authentication_check
      authenticate_or_request_with_http_basic do |user, password|
        user == "admin" && password == "hedra21"
      end
    end
end
