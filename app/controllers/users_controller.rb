class UsersController < ApplicationController
  before_filter :secure_organizer_id, :only => [:edit, :update, :edit_password]
  layout 'public'

  def show
    @user = current_user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      cookies[:auth_token] = @user.auth_token
      redirect_to app_home_path, notice: "Obrigado pelo seu cadastro!"
    else
      render "new"
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      redirect_to user_path(@user), :notice => 'Seu perfil foi alterado!'
    else
      render :edit
    end
  end

  def edit_password
    @user = current_user
  end
end
