class Admin::ProjectsController < Admin::ApplicationController
  def index
    @projects = Project.includes([:book, :client]).all
  end

  def show
    @project = Project.find(params[:id])
  end
end
