class CollaborationsController < ApplicationController
  before_filter :authentication_check
  before_filter :find_book

  def index
    @collaborations = @book.collaborators.all
  end

  def show
    @collaboration = Collaboration.find(params[:id])
  end

  def new
    @collaboration = Collaboration.new
  end

  def edit
    @collaboration = Collaboration.find(params[:id])
  end

  def create
    @collaboration = Collaboration.new(params[:collaboration])

    if @collaboration.save
      redirect_to @collaboration, notice: 'Collaboration was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @collaboration = Collaboration.find(params[:id])

    if @collaboration.update_attributes(params[:collaboration])
      redirect_to @collaboration, notice: 'Collaboration was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @collaboration = Collaboration.find(params[:id])
    @collaboration.destroy

    redirect_to collaborations_url
  end

  private

  def find_book
    @book = Book.find_by_uuid_or_id(params[:book_id])
  end
end
