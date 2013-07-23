class Admin::DashboardController < Admin::ApplicationController
  def index
  	if params[:impersonate_user_id].blank?
  		@projects = Project.includes([:book, :client]).all
  	else
    	@user = User.find(params[:impersonate_user_id])
	    session[:auth_token] = @user.auth_token
	    redirect_to app_home_path
    end
  end
end
