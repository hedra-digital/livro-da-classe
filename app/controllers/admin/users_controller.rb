class Admin::UsersController < Admin::ApplicationController

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
    @profiles = Profile.all.collect {|b| [ b.desc, b.id ] }
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
    @books = Book.where("organizer_id != #{@user.id}")
    @user_books = []
    @user_books = @user_books.concat(@user.books).flatten
    @books = @books - @user_books
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