class TextsController < ApplicationController
  before_filter :find_resource, :only => [:show, :edit, :update, :destroy, :finish]
  before_filter :define_user_level, :only => [:show, :new, :edit]

  # GET /texts/1
  # GET /texts/1.json
  def show    
    @comment = Comment.new
    if @text.title.nil? || @text.content.nil?
      redirect_to edit_book_text_path(@book.uuid,@text.uuid)
    else
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @text }
      end
    end
  end

  # GET /texts/new
  # GET /texts/new.json
  def new
    @book                   = Book.find_by_uuid_or_id(params[:book_id])    
    session['current_book'] = @book.id if @book.present?
    @text                   = Text.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @text }
    end
  end

  # GET /texts/1/edit
  def edit
  end

  # POST /texts
  # POST /texts.json
  def create
    @book = Book.find(params[:book_id])
    @text = Text.new(params[:text])    
    @text.books << Book.find(session['current_book'])

    respond_to do |format|
      if @text.save
        format.html { redirect_to edit_book_text_path(@book.uuid, @text.uuid), notice: 'Text was successfully created.' }
        format.json { render json: @text, status: :created, location: @text }
      else
        format.html { render action: "new" }
        format.json { render json: @text.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /texts/1
  # PUT /texts/1.json
  def update
    respond_to do |format|
      if @text.update_attributes(params[:text])
        format.html { redirect_to book_text_path(@book.uuid, @text.uuid), notice: 'Text was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @text.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /texts/1
  # DELETE /texts/1.json
  def destroy
    @text.destroy

    respond_to do |format|
      format.html { redirect_to "/admin" }
      format.json { head :no_content }
    end
  end

  def finish
    @text.update_attribute(:finished_at, Time.now)
    respond_to do |format|
      format.html { redirect_to action: "show", notice: 'Text was marked as finished' }
      format.json { render json: @text.errors, status: :unprocessable_entity }
    end
  end

  private
  
  def find_resource
    @text = Text.find_by_uuid_or_id(params[:id])
    @book = Book.find_by_uuid_or_id(params[:book_id])
  end

  def define_user_level
    session['student_logged'] = true unless session['professor_logged'] ||  session['admin_logged']
  end
end
