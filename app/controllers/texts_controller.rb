class TextsController < ApplicationController
  before_filter :authentication_check
  before_filter :find_book
  before_filter :secure_book, :only => [:update, :create]

  def index
    @texts = @book.texts.all
  end

  def show
    @text = Text.find_by_uuid_or_id(params[:id])
    @book = @text.book
  end

  def new
    @text = Text.new
  end

  def edit
    @text = Text.find_by_uuid_or_id(params[:id])
  end

  def create
    @text       = Text.new(params[:text])
    @text.book  = @book
    @text.title = "Novo texto"
    if @text.save
      redirect_to edit_book_text_path(@book.uuid, @text.uuid)
    else
      render :new
    end
  end

  def update
    @text = Text.find_by_uuid_or_id(params[:id])
    if @text.update_attributes(params[:text])
      redirect_to book_text_path(@book.uuid, @text.uuid), notice: 'Text was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @text = Text.find_by_uuid_or_id(params[:id])
    @text.destroy
    redirect_to book_path(@book.uuid)
  end

  def sort
    params[:text].each_with_index do |id, index|
      @book.texts.update_all({position: index+1}, {id: id})
    end
    render :nothing => true
  end


  private

  def find_book
    @book = Book.find_by_uuid_or_id(params[:book_id])
  end

  def secure_book
    params[:text].delete(:book) if params[:text].present?
  end
end
