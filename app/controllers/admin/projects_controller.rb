class Admin::ProjectsController < Admin::ApplicationController

  def index
    @projects = Project.includes([:book, :client]).where("books.publisher_id = #{current_publisher}").all
    @projects.sort! { |a,b| a.book.directory_name.downcase <=> b.book.directory_name.downcase }
  end

  def show
    @project = Project.find(params[:id])
  end

  def edit
    @project = Project.find(params[:id])
    @statuses = BookStatus.all.collect {|b| [ b.desc, b.id ] }
  end

  def update
    @project = Project.find(params[:id])
    @project.update_attributes(params[:project])
    if @project.save
      redirect_to admin_root_path, :notice => "Projeto atualizado."
    else
      render :edit
    end
  end

  def impersonate
    @project = Project.find(params[:id])
    session[:auth_token] = @project.book.organizer.auth_token
    redirect_to app_home_path
  end

  def refresh
    BooksGenerateWorker.perform_async
    redirect_to admin_root_path, :notice => "Os projetos estão sendo atualizados..."
  end
end
