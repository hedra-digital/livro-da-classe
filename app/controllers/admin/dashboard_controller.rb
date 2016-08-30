class Admin::DashboardController < Admin::ApplicationController

  skip_before_filter :authentication_admin_check, if: -> { current_user and current_user.publisher? }

  def index
    if params[:impersonate_user_id].blank?

      @projects = Project.order('updated_at DESC').includes(:book)
      remove_projects_inconsistent
      @projects.sort! { |a, b| b.accessed_at <=> a.accessed_at }
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

  def manual
    @content = ''
    if File.exist? MANUAL_CONTENT_FILE_PATH
      File.open(MANUAL_CONTENT_FILE_PATH, 'r') do |file|
        while (line = file.gets)
          @content << line
        end
      end
    end
  end

  def manual_update
    File.open(MANUAL_CONTENT_FILE_PATH, 'w') { |io| io.write(params[:content]) }
    redirect_to admin_manual_url
  end

  private

  def remove_projects_inconsistent
    @projects.delete_if do |project|
      inconsist = false
      if project.book.nil? || project.book.book_data.nil?
        logger.warn "WARN - Projeto Inconsistente: Project id ##{project.id}"
        inconsist = true
      end
      inconsist
    end
  end
end
