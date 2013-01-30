class PagesController < ApplicationController

  def home
    render :layout => 'public'
  end

  def apphome
    render :layout => 'application'
  end

end
