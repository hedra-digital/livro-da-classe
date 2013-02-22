class UsersController < ApplicationController
  before_filter :authentication_check, :only => [:edit, :update, :edit_password]
  before_filter :resource, :only => [:show, :edit, :update, :email]

  layout        :choose_layout

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:auth_token] = @user.auth_token
      redirect_to app_home_path, notice: "Obrigado pelo seu cadastro!"
    else
      render :new
    end
  end

  def edit
  end

  def update
    @user = current_user
    if update_user
      redirect_to user_path(@user), :notice => 'Seu perfil foi alterado!'
    else
      if params[:email_gate].present?
        render :email
      else
        render :edit
      end
    end
  end

  def email
  end

  private

  def resource
    @user = current_user
  end

  def update_user
    if params[:email_gate]
      @user.update_attribute(:email, params[:user]["email"]) ? true : false
    else
      @user.update_attributes(params[:user]) ? true : false
    end
  end
end
