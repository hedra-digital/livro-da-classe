class Admin::BookStatusesController < Admin::ApplicationController

  def index
    @statuses = BookStatus.all
  end

  def new
    @status = BookStatus.new
  end

  def create
    @status = BookStatus.new(params[:book_status])
    if @status.save
      redirect_to admin_book_statuses_path, :notice => "Uma novo status foi definido."
    else
      render :new
    end
  end

  def edit
    @status = BookStatus.find(params[:id])
  end

  def update
    @status = BookStatus.find(params[:id])
    @status.update_attributes(params[:book_status])
    if @status.save
      redirect_to admin_book_statuses_path, :notice => "Status atualizado."
    else
      render :edit
    end
  end

  def destroy
    @status = BookStatus.find(params[:id])
    @status.destroy
    redirect_to admin_book_statuses_path, :notice => "Status removido com sucesso."
  end

end