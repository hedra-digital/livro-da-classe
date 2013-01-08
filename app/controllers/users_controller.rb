class UsersController < ApplicationController
  layout 'public'
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if user.save
      redirect_to root_url, notice: "Obrigado pelo seu cadastro!"
    else
      render "new"
    end
  end
end
