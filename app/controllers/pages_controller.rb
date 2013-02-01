class PagesController < ApplicationController
  layout :choose_layout

  def home
  end

  private

  def choose_layout
    current_user ? "application" : "public"
  end

end
