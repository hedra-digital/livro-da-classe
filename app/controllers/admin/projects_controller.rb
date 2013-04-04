class Admin::ProjectsController < Admin::ApplicationController
  def index
    @projects = Project.includes([:book, :client]).all
  end

  def show
    @project = Project.find(params[:id])
  end

  def edit
    @project = Project.find(params[:id])
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
end
