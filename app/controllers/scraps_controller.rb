class ScrapsController < ApplicationController

  def index
    @book = Book.find_by_uuid_or_id(params[:book_id])
    @scraps = Scrap.where(:parent_scrap_id => nil, :book_id => @book.id).order('created_at DESC').all

    if @scraps.count == 0 and can_write?
      redirect_to new_scrap_path(@book.id)
    end
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

    AdminMailer.scrap_notifier(@book, @scrap).deliver

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

    AdminMailer.scrap_notifier(parent_scrap.book, @scrap).deliver

    parent_scrap.answered = false
    parent_scrap.save
    render layout: false
  end

end