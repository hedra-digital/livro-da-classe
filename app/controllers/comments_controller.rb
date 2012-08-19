class CommentsController < ApplicationController
  before_filter :find_related_resources
  #before_filter :find_resource

  def create
    @text           = Text.find_by_uuid_or_id(params[:text_id])  
    @comment        = @text.comments.new(params[:comment])
    @comment.author = current_user
       
    respond_to do |format|
      if @comment.save
        format.html { redirect_to book_text_path(@book.uuid, @text.uuid), notice: 'Text was successfully created.' }
        format.json { render json: @text, status: :created, location: @text }
      else
        format.html { redirect_to book_text_path(@book.uuid, @text.uuid), notice: 'An error happened while adding your comment.' }
        format.json { render json: @text.errors, status: :unprocessable_entity }
      end
    end
  end
  

  private

  def find_related_resources
    @book = Book.find_by_uuid_or_id(params[:book_id])  
    @text = Text.find_by_uuid_or_id(params[:text_id])      
  end
  
  # def find_resource
  #   @text = Text.find_by_uuid_or_id(params[:text_id])  
  # end
end
