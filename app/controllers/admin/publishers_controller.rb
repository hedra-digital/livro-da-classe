class Admin::PublishersController < Admin::ApplicationController

  def index
    @publishers = Publisher.all
  end

  def new
    @publisher = Publisher.new
  end

  def create
    @publisher = Publisher.new(params[:publisher])
    if @publisher.save
      redirect_to admin_publishers_path, :notice => "Uma nova editora foi definida."
    else
      render :new
    end
  end

  def edit
    @publisher = Publisher.find(params[:id])
  end

  def update
    @publisher = Publisher.find(params[:id])
    @publisher.update_attributes(params[:publisher])
    if @publisher.save
      redirect_to admin_publishers_path, :notice => "Editora atualizada."
    else
      render :edit
    end
  end

  def destroy
    @publisher = Publisher.find(params[:id])
    @publisher.destroy
    redirect_to admin_publishers_path, :notice => "Editora removida com sucesso."
  end
end
