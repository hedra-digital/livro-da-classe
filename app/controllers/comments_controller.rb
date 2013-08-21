class CommentsController < ApplicationController
  before_filter :find_resources

  def index
    @comments = Comment.all
  end

  def create
    @comment        = Comment.new(params[:comment])
    @comment.user   = session['current_user']
    @comment.user ||= current_user
    @comment.text   = @text

    if @comment.save
      redirect_to book_text_path(@book.uuid, @text.uuid), notice: "Comentario adicionado"
    else
      redirect_to book_text_path(@book.uuid, @text.uuid)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to book_text_path(@book.uuid, @text.uuid)
  end

  private

  def find_resources
    @book = Book.find_by_uuid_or_id(params[:book_id])
    @text = Text.find_by_uuid_or_id(params[:text_id])
  end

end
