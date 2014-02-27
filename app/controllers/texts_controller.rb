class TextsController < ApplicationController
  before_filter :authentication_check
  before_filter :find_book
  before_filter :secure_book, :only => [:update, :create]

  def index
    @texts = @book.texts.order('-position DESC')
  end

  def show
    @text = Text.find_by_uuid_or_id(params[:id])
    @book = @text.book
    @comment = Comment.new
  end

  def new
    @text = Text.new
  end

  def edit
    @text = Text.find_by_uuid_or_id(params[:id])
    session['book_id'] = @text.book.id
  end

  def create
    @text       = Text.new(params[:text])
    @text.book  = @book
    @text.title = I18n.translate(:initial_text_title)
    @text.user  = current_user
    if @text.save
      redirect_to edit_book_text_path(@book.uuid, @text.uuid)
    else
      render :new
    end
  end

  def update
    @text = Text.find_by_uuid_or_id(params[:id])
    @text.valid_content = @text.validate_content
    if @text.update_attributes(params[:text])
      Version.commit_file(@text.book.directory, @text, current_user.profile.desc, current_user.name, params[:text][:git_message])
      redirect_to book_text_path(@book.uuid, @text.uuid), :notice => t('activerecord.successful.messages.updated', :model => @text.class.model_name.human)
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

  def enable_or_disable
    text = Text.find_by_uuid_or_id(params[:uuid])
    text.enabled = (text.is_enabled?) ? false : true
    text.save
    redirect_to book_texts_path(text.book.uuid)
  end

  private

  def find_book
    @book = Book.find_by_uuid_or_id(params[:book_id])
  end

  def secure_book
    params[:text].delete(:book) if params[:text].present?
  end
end
