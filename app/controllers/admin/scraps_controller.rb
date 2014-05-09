class Admin::ScrapsController < Admin::ApplicationController

  skip_before_filter :authentication_admin_check 
  before_filter :auth_admin_or_publisher 

  def index
    @scraps = Scrap.where(:parent_scrap_id => nil).order('answered, created_at DESC').all
  end

  def new
    @scrap = Scrap.new
    @books = Book.all
  end

  def create
    @scrap = Scrap.new(params[:scrap])
    @scrap.is_admin = true
    @scrap.answered = true
    @scrap.admin_name = Publisher.find(current_publisher).name
    if @scrap.save

      AdminMailer.scrap_notifier(@scrap.book, @scrap).deliver

      redirect_to admin_scraps_path, :notice => "Uma recado foi escrito."
    else
      render :new
    end
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
    @scrap.is_admin = true
    @scrap.admin_name = 'Editora Hedra'
    @scrap.book_id = parent_scrap.book.id
    @scrap.save

    parent_scrap.answered = true
    parent_scrap.save

    AdminMailer.scrap_notifier(@scrap.book, @scrap).deliver
    
    render layout: false
  end
end

# for role publisher
# @scraps = Scrap.joins(:book).where(:parent_scrap_id => nil, 'books.organizer_id' => current_user.id).order('answered, created_at DESC').all
# @books = Book.where('organizer_id' => current_user.id)
