class Admin::ProjectsController < Admin::ApplicationController

  skip_before_filter :authentication_admin_check, :only => [:show, :impersonate, :edit, :update]
  before_filter :auth_admin_or_publisher, :only => [:show, :impersonate, :edit, :update]

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
    cookies[:auth_token] = @project.book.organizer.auth_token
    redirect_to app_home_path
  end

  def refresh
    background do 
      Project.all.each do |project|
        project.book.pdf
      end
    end 
    redirect_to admin_root_path, :notice => "Os projetos estão sendo atualizados..."
  end

  def push
    VersionWorker.perform_async
    redirect_to admin_root_path, :notice => "Os projetos estão sendo enviados para o repositório..."
  end
end
