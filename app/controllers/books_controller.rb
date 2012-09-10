class BooksController < ApplicationController
  before_filter :authentication_check, :only => [:index]
  before_filter :find_resource, :only => [:show, :edit, :update, :destroy, :finish, :pdf]
  
  # GET /books
  # GET /books.json
  def index
    @books = Book.all
    @texts = Text.all
    @schools = School.all
    session['admin_logged'] = true;

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @books }
    end
  end

  # GET /books/1
  # GET /books/1.json
  def show
    @url_alunos = Googl.shorten(welcome_url(@book.uuid)).short_url
    session['professor_logged'] = true unless session['admin_logged'];
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @book }
      format.pdf
    end
  end

  # GET /books/new
  # GET /books/new.json
  def new
    @book = Book.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @book }
    end
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(params[:book])

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render json: @book, status: :created, location: @book }
      else
        format.html { render action: "new" }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /books/1
  # PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update_attributes(params[:book])
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy

    respond_to do |format|
      format.html { redirect_to books_url }
      format.json { head :no_content }
    end
  end

  def finish
    @book.update_attribute(:finished_at, Time.now)
    respond_to do |format|
      format.html { redirect_to action: "show", notice: 'Book was marked as finished' }
      format.json { render json: @book.errors, status: :unprocessable_entity }
    end
  end

  def pdf    
  end

  private

  def find_resource
   @book = Book.find_by_uuid_or_id(params[:id])
  end
end