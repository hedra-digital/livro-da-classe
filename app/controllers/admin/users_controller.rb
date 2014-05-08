class Admin::UsersController < Admin::ApplicationController

  skip_before_filter :authentication_admin_check, only: [:index, :books, :add_book, :remove_book]
  before_filter :auth_admin_or_publisher, only: [:index, :books, :add_book, :remove_book]

  def index
    if current_user.admin?
      @users = User.all
    elsif current_user.publisher?
      @users = User.joins(:books).where('books.id in (?)', current_user.organized_books).group('users.id')
    end      
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
    @user_books = []
    @user_books = @user_books.concat(@user.books).flatten

    if current_user.admin?
      @books = Book.where("organizer_id != #{@user.id}") - @user_books
    elsif current_user.publisher?
      # data scope check
      if !User.joins(:books).where('books.id in (?)', current_user.organized_books).include?(@user)
        redirect_to signin_path
        return
      end

      @books = current_user.organized_books - @user_books
    end
  end

  def add_book
    @user = User.find(params[:id])
    @book = Book.find(params[:user][:book_id])

    # data scope check
    if current_user.publisher?
      if !User.joins(:books).where('books.id in (?)', current_user.organized_books).include?(@user)
        redirect_to signin_path
        return
      end

      if !current_user.organized_books.include?(@book)
        redirect_to signin_path
        return
      end
    end

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

    # data scope check
    if current_user.publisher?
      if !User.joins(:books).where('books.id in (?)', current_user.organized_books).include?(@user)
        redirect_to signin_path
        return
      end

      if !current_user.organized_books.include?(@book)
        redirect_to signin_path
        return
      end
    end

    @user.books.delete(@book)

    if @user.save
      redirect_to admin_users_path, :notice => "Foi removido o acesso do livro para o usuário."
    else
      render :books
    end
  end

end