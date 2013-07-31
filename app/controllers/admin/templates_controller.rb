class Admin::TemplatesController < Admin::ApplicationController
  def index
    @templates = Livrodaclasse::Application.latex_templates

  end
end
