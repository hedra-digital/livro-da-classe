class ScrapsController < ApplicationController

  def index
    @scraps = Scrap.where(:parent_scrap_id => nil).order('created_at DESC').all
  end

  def new
    @scrap = Scrap.new
    @book = Book.find(params[:id])
  end

  def show
    @scrap = Scrap.find params[:id]
    @book = Book.find(@scrap.book_id)
  end

  def create
    @scrap = Scrap.create(content: params[:scrap][:content], is_admin: false, answered: false, book_id: params[:scrap][:book_id])
    @book = Book.find(params[:scrap][:book_id])
    @book.scraps << @scrap
    redirect_to book_path(@book), :notice => "Recado criado."
  end

  def thread
    @scrap = Scrap.find(params[:id])
    @book = @scrap.book
  end

  def answer
    parent_scrap = Scrap.find(params[:parent])
    @scrap = Scrap.new
    @scrap.parent_scrap_id = parent_scrap.id
    @scrap.content = params[:content]
    @scrap.book_id = parent_scrap.book.id
    @scrap.save

    parent_scrap.answered = false
    parent_scrap.save
    render layout: false
  end

end