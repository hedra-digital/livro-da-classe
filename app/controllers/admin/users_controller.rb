class Admin::UsersController < Admin::ApplicationController

  skip_before_filter :authentication_admin_check, only: [:index, :books, :add_book, :remove_book]
  before_filter :auth_admin_or_publisher, only: [:index, :books, :add_book, :remove_book]

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
    @profiles = Profile.all.collect {|b| [ b.desc, b.id ] }
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to admin_users_url,  notice: "Usuário cadastrado!"
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(params[:user])
    if @user.save
      redirect_to admin_users_path, :notice => "Usuário atualizado."
    else
      render :edit
    end
  end

  def books
    @user = User.find(params[:id])
    @user_books = []
    @user_books = @user_books.concat(@user.books).flatten
    @books = Book.where("organizer_id != #{@user.id}") - @user_books
  end

  def add_book
    @user = User.find(params[:id])
    @book = Book.find(params[:user][:book_id])
    @user.books << @book

    if @user.save
      redirect_to admin_users_path, :notice => "Livro foi adicionado para o usuário."
    else
      render :books
    end
  end

  def remove_book
    @user = User.find(params[:id])
    @book = Book.find(params[:book_id])
    @user.books.delete(@book)

    if @user.save
      redirect_to admin_users_path, :notice => "Foi removido o acesso do livro para o usuário."
    else
      render :books
    end
  end

end

# data scrope for publisher
# @users = User.joins(:books).where('books.id in (?)', current_user.organized_books).group('users.id')
# current_user.organized_books.include?(@book)
