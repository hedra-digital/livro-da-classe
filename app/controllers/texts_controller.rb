require "#{Rails.root}/lib/google_connector.rb"

class TextsController < ApplicationController
  before_filter :authentication_check
  before_filter :find_book
  before_filter :secure_book, :only => [:update, :create]

  def index
    @texts = @book.texts.order('position')
  end

  def show
    @text = Text.find_by_uuid_or_id(params[:id])
    @comment = Comment.new
  end

  def new
    @text = Text.new
  end

  def edit
    @text = Text.find_by_uuid_or_id(params[:id])
    session['book_id'] = @text.book.id
  end

  def upload
    @book = Book.find_by_uuid_or_id(params[:id])
    connector = GoogleConnector.new
    content = connector.download_as_html('147y43kueJto4bn_TIGtbxABMzXnvA3W4OmClcS9C8kc')
    @text       = Text.new
    @text.content = content
    @text.book  = @book
    @text.title = I18n.translate(:initial_text_title)
    @text.user  = current_user
    if @text.save
      @text.book.push_to_bitbucket
      @texts = @book.texts.order('position')
      render :index
    else
      render :new
    end
  end

  def create
    @text       = Text.new(params[:text])
    @text.book  = @book
    @text.title = I18n.translate(:initial_text_title)
    @text.user  = current_user
    if @text.save
      @text.book.push_to_bitbucket
      redirect_to edit_book_text_path(@book.uuid, @text.uuid)
    else
      render :new
    end
  end

  def update
    @text = Text.find_by_uuid_or_id(params[:id])
    @text.valid_content = @text.validate_content

    # do not save the content, because we need to split it later
    content = params[:text].delete(:content)

    if @text.update_attributes(params[:text])
      @text.content = content

      chapters, footnotes = Text.split_chpaters(@text.content_with_head)

      chapter_ids = Text.save_split_chapters(chapters, footnotes, @book, current_user)

      # the new content with data id will be render to ckeditor, so no dump chapter after ajaxSave
      new_content = []
      chapter_ids.each_with_index do |id, index|

        if index == 0
          new_content << Text.find(id).content
        else
          new_content << Text.find(id).content_with_h1_head
        end
      end

      Text.set_positoins_after_split(chapter_ids)

      @text.book.push_to_bitbucket

      respond_to do |format|
        format.html  {redirect_to book_text_path(@book.uuid, @text.uuid), :notice => t('activerecord.successful.messages.updated', :model => @text.class.model_name.human)}
        format.json  { render :json => {:refresh => true, :content => new_content.join()} }
      end
    else
      render :edit
    end
  end

  def destroy
    @text = Text.find_by_uuid_or_id(params[:id])
    @text.destroy
    @text.book.push_to_bitbucket
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

  def all
    @text = Text.new
    @text.content = @book.texts.order('position').map(&:content_with_head).join()
  end

  def save_all
    # TODO not a good idea to use session, need refatcory the code base
    session['book_id'] = @book.id

    chapters, footnotes = Text.split_chpaters(params[:text][:content])

    chapter_ids = Text.save_split_chapters(chapters, footnotes, @book, current_user)

    chapter_ids.each_with_index do |id, index|
      Text.find(id).update_attribute(:position, index)
    end

    #delete chapter if not in chapter_ids
    @book.texts.each do |t|
      t.destroy unless chapter_ids.include?(t.id)
    end

    @book.push_to_bitbucket

    respond_to do |format|
      format.html  {redirect_to book_texts_path(@book.uuid), :notice => t('activerecord.successful.messages.updated', :model => Text.model_name.human)}
      format.json  { render :json => {:ok => :ture} }
    end

  end

  private

  def find_book
    @book = Book.find_by_uuid_or_id(params[:book_id])
  end

  def secure_book
    params[:text].delete(:book) if params[:text].present?
  end
end
