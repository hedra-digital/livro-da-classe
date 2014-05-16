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
      respond_to do |format|
        format.html  {redirect_to book_text_path(@book.uuid, @text.uuid), :notice => t('activerecord.successful.messages.updated', :model => @text.class.model_name.human)}
        format.json  { render :json => @text }
      end
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

  def all
    @text = Text.new
    @text.content = @book.texts.map(&:content_with_head).join()
  end

  def save_all
    doc = Nokogiri::HTML(params[:text][:content])

    chapters = []
    current_chapter = [] # current chapter is a html nodes arrary

    doc.css('body > *').each do |level_1_node|
      if (level_1_node.node_name == "section" and level_1_node.attribute("class").value == "chapter")

        chapters << current_chapter if current_chapter.count > 0
        current_chapter = []
      end

      current_chapter << level_1_node
    end
    # add the last chapter
    chapters << current_chapter if current_chapter.count > 0

    #modify chapter
    chapters.each do |chapter|

      # chapter's first node must be "section"
      chapter_node = chapter.shift 
      text = Text.find_by_uuid(chapter_node.attribute("data-id").value)

      text.title = chapter_node.at_css("h1").text
      text.subtitle = chapter_node.at_css("h3").text
      text.author = chapter_node.at_css("p").text

      text.content = chapter.map(&:to_html).join()
      text.save
    end

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
