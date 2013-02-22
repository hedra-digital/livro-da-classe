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
    collaborator = User.where(:email => params[:user][:email]).first
    unless collaborator
      collaborator = User.new(params[:user], :without_protection => true)
      collaborator.valid?
      if collaborator.errors[:email].present?
        redirect_to new_book_collaborator_path(@book.uuid), :notice => "O e-mail informado não é válido." and return
      else
        collaborator.save!(:validate => false)
      end
    end
    collaborator.send_book_invitation(current_user, @book.uuid)
    redirect_to book_collaborators_path(@book.uuid), :notice => "Email enviado com instruções para o colaborador."
  end

  def edit
    unless current_user = @collaborator
      cookies.delete(:auth_token)
      session[:auth_token] = nil
    else
      @book.users << @collaborator
      redirect_to app_home_path, :notice => "Você foi adicionado como colaborador do livro <em>#{@book.title}</em>."
    end
  end

  def update
    if @collaborator.password_reset_sent_at < 2.hours.ago
      redirect_to root_path, :notice => "O link já expirou. Por favor, peça ao organizador do livro para enviar um novo convite."
    elsif @collaborator.update_attributes(params[:user])
      @book.users << @collaborator
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
