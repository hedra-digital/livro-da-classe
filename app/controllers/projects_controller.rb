# encoding: UTF-8

class ProjectsController < ApplicationController
  before_filter :authentication_check
  before_filter :find_book

  def new
    client = Client.new(:user_id => current_user.id)
    @project = Project.new(:client => client, :book_id => @book.id)
  end

  def create
    @project = Project.new(params[:project].merge(:book_id => @book.id))
    if @project.save
      redirect_to book_path(@book.uuid), :notice => "Seu Livro da Classe já foi criado."
    else
      render :new
    end
  end

  def edit
    @project = Project.where(:book_id => @book.id).first
  end

  def update
    @project = Project.where(:book_id => @book.id).first
    if @project.update_attributes(params[:project])
      redirect_to book_path(@book.uuid), :notice => "Projeto atualizado com sucesso"
    else
      render :edit
    end
  end

  def terms_of_service
    respond_to do |format|
      format.pdf do
        render :pdf => 'terms_of_service',
               :margin => {:top => '18mm', :left => '10mm', :right => '10mm', :bottom => '20mm'},
               :show_as_html => params[:debug].present?
      end
    end
  end

  private

  def find_book
    @book = Book.find_by_uuid_or_id(params[:book_id])
  end
end
