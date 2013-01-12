class UsersController < ApplicationController
  layout 'public'

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect_to app_home_path, notice: "Obrigado pelo seu cadastro!"
    else
      render "new"
    end
  end

end
