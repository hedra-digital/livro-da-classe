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
    @collaborator = @book.collaborators.new(params[:collaborator])

    if @collaborator.save
      redirect_to [@book, @collaborator], notice: 'Collaboration was successfully created.'
    else
      render action: "new"
    end
  end

  def edit
    @collaborator = @book.collaborators.find(params[:id])
  end

  def update
    @collaborator = @book.collaborators.find(params[:id])

    if @collaborator.update_attributes(params[:collaborator])
      redirect_to [@book, @collaborator], notice: 'Collaboration was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @collaborator = @book.collaborators.find(params[:id])
    @collaborator.destroy

    redirect_to book_collaborators_path(@book)
  end

  private

  def find_book
    @book = Book.find_by_uuid_or_id(params[:book_id])
  end
end
