# encoding: utf-8

class CollaboratorsController < ApplicationController
  before_filter :authentication_check
  before_filter :find_book
  before_filter :find_collaborator, :only => [:edit, :update]

  layout        :choose_layout

  def index
    @collaborators = @book.users.all
  end

  def new
    @collaborator = @book.users.new
  end

  def create
    @collaborator = User.new(params[:user], :without_protection => true)
    @collaborator.save!(:validate => false)
    @book.users << @collaborator
    @collaborator.send_book_invitation(current_user, @book.uuid)
    redirect_to book_collaborators_path(@book.uuid), :notice => "Email enviado com instruções para criar a conta."
  end

  def edit
    cookies.delete(:auth_token)
    session[:auth_token] = nil
  end

  def update
    # binding.pry
    if @collaborator.update_attributes(params[:user])
      session[:auth_token] = user.auth_token
      redirect_to app_home_path
    else
      # binding.pry
      render action: "edit"
    end
  end

  private

  def find_book
    @book = Book.find_by_uuid_or_id(params[:book_id])
  end

  def find_collaborator
    @collaborator = @book.users.find_by_password_reset_token!(params[:id])
  end
end
