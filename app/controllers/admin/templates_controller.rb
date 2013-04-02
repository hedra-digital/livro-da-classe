class Admin::TemplatesController < Admin::ApplicationController
  def index
    @templates = Template.all
  end
end
