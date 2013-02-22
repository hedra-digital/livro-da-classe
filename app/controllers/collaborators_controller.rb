# encoding: utf-8

class CollaboratorsController < ApplicationController
  before_filter :authentication_check, :except => :update
  before_filter :find_book
  before_filter :find_collaborator, :only => [:edit, :update, :resend_invitation]

  layout        :choose_layout

  def index
    @collaborators = @book.users.all
  end

  def new
    @collaborator = @book.users.new
  end

  def create
    @collaborator = User.new(params[:user], :without_protection => true)
    @collaborator.save!(:validate => false)
    @book.users << @collaborator
    @collaborator.send_book_invitation(current_user, @book.uuid)
    redirect_to book_collaborators_path(@book.uuid), :notice => "Email enviado com instruções para criar a conta."
  end

  def edit
    if @book.nil? || @collaborator.nil?
      redirect_to root_path, :notice => "Link inválido."
    end
    cookies.delete(:auth_token)
    session[:auth_token] = nil
  end

  def update
    if @collaborator.password_reset_sent_at < 2.hours.ago
      redirect_to root_path, :notice => "O link já expirou. Por favor, peça ao organizador do livro para enviar um novo convite."
    elsif @collaborator.update_attributes(params[:user])
      session[:auth_token] = @collaborator.auth_token
      redirect_to app_home_path
    else
      redirect_to root_path, :notice => "Houve um erro na criação da conta."
    end
  end

  def resend_invitation
    @collaborator.send_book_invitation(current_user, @book.uuid)
    redirect_to book_collaborators_path(@book.uuid), :notice => "Email enviado com instruções para criar a conta."
  end

  private

  def find_book
    @book = Book.find_by_uuid_or_id(params[:book_id])
  end

  def find_collaborator
    @collaborator = @book.users.find_by_password_reset_token!(params[:id])
  end
end
