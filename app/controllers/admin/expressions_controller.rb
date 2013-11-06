class Admin::ExpressionsController < Admin::ApplicationController

  def index
    @expressions = Expression.all
  end

  def new
    @expression = Expression.new
  end

  def create
    @expression = Expression.new(params[:expression])
    if @expression.save
      redirect_to admin_expressions_path, :notice => "Uma nova expressão foi definida."
    else
      render :new
    end
  end

  def edit
    @expression = Expression.find(params[:id])
  end

  def update
    @expression = Expression.find(params[:id])
    @expression.update_attributes(params[:expression])
    if @expression.save
      redirect_to admin_expressions_path, :notice => "Expressão atualizada."
    else
      render :edit
    end
  end

  def destroy
    @expression = Expression.find(params[:id])
    @expression.destroy
    redirect_to admin_expressions_path, :notice => "Expressão removida com sucesso."
  end

end