class Admin::DashboardController < Admin::ApplicationController
  def index
    @projects = Project.includes([:client, :book]).all
  end
end
