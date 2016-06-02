require "#{Rails.root}/lib/google_connector.rb"
require "#{Rails.root}/lib/google_html.rb"

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

  def create
    content = ''
    begin
      if params[:upload].present?
        content = add_file_uploaded
        @book = Book.find_by_uuid_or_id(params[:id])
        chapters, footnotes = Text.split_chpaters(content)
        chapter_ids = Text.save_split_chapters(chapters, footnotes, @book, current_user)
        Text.set_positoins_after_split(chapter_ids)
        return redirect_to book_texts_path(@book.uuid)
      end
    rescue Exception => e
      puts e.message
      puts e.backtrace.inspect
    end

    @text       = Text.new(params[:text])
    @text.book  = @book
    @text.title = I18n.translate(:initial_text_title)
    @text.user  = current_user
    @text.valid_content = @text.validate_content

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

  def cancel
    @text = Text.find_by_uuid_or_id(params[:text_id])
    if empty_chapter @text
      @text.destroy
      @text.book.push_to_bitbucket
      redirect_to book_path(@book.uuid), notice: 'Capítulo em branco removido.'
    else
      redirect_to book_path(@book.uuid)
    end
  end

  private

  def find_book
    @book = Book.find_by_uuid_or_id(params[:book_id])
  end

  def secure_book
    params[:text].delete(:book) if params[:text].present?
  end

  def add_file_uploaded
    connector = GoogleConnector.new

    upload = params[:upload]
    filepath = Rails.root.join('/tmp', upload.original_filename)
    File.open(filepath, 'wb') do |file|
      file.write(upload.read)
    end
    google_filedocument_id = connector.upload(filepath.to_s)
    content = connector.download_as_html(google_filedocument_id)
    content = GoogleHtml.validate_google_html(content)
    File.delete(filepath.to_s)
    content
  rescue Exception => e
    puts e.message
    puts e.backtrace.inspect
  end

  def empty_chapter(text)
    ( (text.title.empty? || text.title == I18n.translate(:initial_text_title)) && text.content.empty?  ) ? true : false
  end
end
