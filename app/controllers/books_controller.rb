class BooksController < ApplicationController
  before_filter :authentication_check
  before_filter :ominiauth_user_gate
  before_filter :secure_organizer_id, :only => [:create, :update]
  before_filter :resource, :only => [:show, :edit, :destroy, :update]

  def index
    @organized_books = current_user.organized_books
    @collaborated_books = current_user.books
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.pdf
    end
  end

  def new
    @book = current_user.organized_books.new
  end

  def create
    @book = current_user.organized_books.new(params[:book])

    if @book.save
      redirect_to book_path(@book.uuid), notice: 'Book was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @book.update_attributes(params[:book])
      redirect_to book_path(@book.uuid), notice: 'Book was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @book.destroy
    redirect_to books_url
  end

  private

  def secure_organizer_id
    params[:book].delete(:organizer)
  end

  def resource
    @book = Book.find_by_uuid_or_id(params[:id])
  end
end
