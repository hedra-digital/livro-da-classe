class Admin::DashboardController < Admin::ApplicationController
  def index
    @projects = Project.includes([:book, :client]).all
  end
end
