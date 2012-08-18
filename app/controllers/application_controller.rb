class ApplicationController < ActionController::Base
  protect_from_forgery

  def logout
	session['admin_logged']     = nil;
	session['professor_logged'] = nil;
	session['student_logged']   = nil;
	redirect_to "/"
  end

  private
    def authentication_check
      authenticate_or_request_with_http_basic do |user, password|
        user == "admin" && password == "hedra21"
      end
    end
end

