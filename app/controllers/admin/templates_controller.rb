class Admin::TemplatesController < Admin::ApplicationController
  def index
    @templates = LATEX_TEMPLATES
  end
end
