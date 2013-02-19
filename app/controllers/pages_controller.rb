class PagesController < ApplicationController
  before_filter :public_view_check
  layout        :choose_layout

  def home
  end

  private

  def public_view_check
    redirect_to app_home_path if current_user
  end
end
