class Admin::DashboardController < Admin::ApplicationController

  skip_before_filter :authentication_admin_check, if: -> { current_user and current_user.publisher? }

  def index
  	if params[:impersonate_user_id].blank?
      @projects = Project.includes([:book, :client]).where("books.publisher_id = #{current_publisher}").all
      @projects.sort! { |a,b| a.book.directory_name.downcase <=> b.book.directory_name.downcase }
  	else
    	@user = User.find(params[:impersonate_user_id])
	    session[:auth_token] = @user.auth_token
	    redirect_to app_home_path
    end
  end

  def default_cover
  	DefaultCover.new.save if DefaultCover.first.nil? 

  	@default_cover = DefaultCover.first
  end

  def update_default_cover
  	DefaultCover.first.update_attributes(params[:default_cover])
  	flash[:success] = 'Capa padrão atualizada com sucesso'
  	redirect_to admin_root_path
  end

  def scraps
    @scraps = Scrap.includes(:book).order("created_at DESC").all
  end

  def revision
  end
end
