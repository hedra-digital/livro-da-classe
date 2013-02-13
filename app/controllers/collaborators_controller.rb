# encoding: utf-8

class CollaboratorsController < ApplicationController
  before_filter :authentication_check
  before_filter :find_book

  def index
    @collaborators = @book.collaborators.all
  end

  def show
    @collaborator = @book.collaborators.find(params[:id])
  end

  def new
    @collaborator = @book.collaborators.new
  end

  def create
    @collaborator = @book.collaborators.new(params[:user], :without_protection => true)
    @collaborator.save!(:validate => false)
    binding.pry
    @collaborator.send_book_invitation(current_user, @book.uuid)
    redirect_to book_collaborators_path(@book), :notice => "Email enviado com instruções para criar a conta."
  end

  def edit
    @collaborator = @book.collaborators.find_by_password_reset_token!(params[:id])
  end

  def update
    @collaborator = @book.collaborators.find_by_password_reset_token!(params[:id])

    if @collaborator.update_attributes(params[:user])
      redirect_to book_collaborator_path(@book, @collaborator), notice: 'Collaboration was successfully updated.'
    else
      render action: "edit"
    end
  end

  # def destroy
  #   @collaborator = @book.collaborators.find(params[:id])
  #   @collaborator.destroy

  #   redirect_to book_collaborators_path(@book)
  # end

  private

  def find_book
    @book = Book.find_by_uuid_or_id(params[:book_id])
  end
end
