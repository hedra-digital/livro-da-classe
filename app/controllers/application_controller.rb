class ApplicationController < ActionController::Base
	protect_from_forgery

	def logout
		session['admin_logged']     = nil;
		session['professor_logged'] = nil;
		session['student_logged']   = nil;
		redirect_to "/index.html"
	end

	def get_cities_by_state
		@cities = BrazilianStates.find_cities_by_state(params[:name].downcase)

		respond_to do |format|
			format.html { render :text => @cities.inspect }
			format.js
		end
	end

	private
		def authentication_check
			authenticate_or_request_with_http_basic do |user, password|
				user == "admin" && password == "hedra21"
			end
		end
end