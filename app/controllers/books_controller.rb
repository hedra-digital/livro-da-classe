# encoding: UTF-8

class BooksController < ApplicationController
  before_filter :authentication_check, :except => [:show]
  before_filter :ominiauth_user_gate, :except => [:show]
  before_filter :secure_organizer_id, :only => [:create, :update]
  before_filter :resource, :only => [:show, :edit, :destroy, :update, :cover_info, :update_cover_info, :generate_cover]

  def index
    @books = []
    @books.concat(current_user.organized_books).concat(current_user.books).flatten
  end

  def cover_info
    @cover_info = @book.cover_info
  end
  
  def update_cover_info
    if @book.cover_info.update_attributes(params[:cover_info])
      redirect_to book_cover_info_path(@book.uuid), notice: 'Capa atualizada com sucesso'
    else
      render :edit
    end
  end

  def generate_cover
    respond_to do |format|
      format.pdf do |pdf|
        send_file pdf_file
        
      end
    end
  end

  def show
    @scraps = Book.find_by_uuid(params[:id]).scraps.order("created_at desc")

    respond_to do |format|
      format.html # show.html.erb
      format.pdf 
    end
  end

  def new
    @book = current_user.organized_books.new
  end

  def create
    @book = current_user.organized_books.new(params[:book].merge(:template => Livrodaclasse::Application.latex_templates[0]))

    if @book.save
      redirect_to book_path(@book.uuid), notice: 'O livro foi criado e já está disponível para você escrever o seu primeiro texto.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @book.update_attributes(params[:book])
      redirect_to book_path(@book.uuid), notice: 'O livro foi criado e já está disponível para você escrever o seu primeiro texto.'
    else
      render :edit
    end
  end

  def destroy
    @book.destroy
    redirect_to books_url
  end
  
  private

  def secure_organizer_id
    params[:book].delete(:organizer)
  end

  def resource
    @book = Book.find_by_uuid_or_id(params[:id])
  end
end
