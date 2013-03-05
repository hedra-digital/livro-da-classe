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

  private

  def find_book
    @book = Book.find_by_uuid_or_id(params[:book_id])
  end
end
