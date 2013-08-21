# encoding: utf-8

class CollaboratorsController < ApplicationController
  before_filter :authentication_check, :except => [:edit, :update]
  before_filter :find_book
  before_filter :find_collaborator, :only => [:edit, :update, :resend_invitation]

  layout        :choose_layout

  def index
    @collaborators = @book.users.all
    @invited_users = Invitation.where(:book_id => @book.id).map { |i| User.where(:id => i.invited_id).first }
  end

  def new
    @collaborator = User.new
  end

  def create
    collaborator = User.where(:email => params[:user][:email]).first
    if collaborator.nil?
      collaborator = User.new(params[:user], :without_protection => true)
      collaborator.valid?
      if collaborator.errors[:email].present?
        redirect_to new_book_collaborator_path(@book.uuid), :notice => "O e-mail informado não é válido." and return
      else
        collaborator.save!(:validate => false)
      end
    elsif @book.users.include?(collaborator)
      redirect_to new_book_collaborator_path(@book.uuid), :notice => "O usuário informado já é colaborador do livro selecionado." and return
    end
    collaborator.send_book_invitation(current_user, @book.uuid)
    Invitation.create(:invited_id => collaborator.id, :book_id => @book.id)
    redirect_to book_collaborators_path(@book.uuid), :notice => "Email enviado com instruções para o colaborador."
  end

  def edit
    if @collaborator.password_digest || @collaborator.provider
      @book.users << @collaborator
      Invitation.where(:invited_id => @collaborator.id, :book_id => @book.id).first.destroy
      session[:auth_token] = @collaborator.auth_token
      redirect_to app_home_path, :notice => "Você foi adicionado como colaborador do livro <em>#{@book.title}</em>."
    else
      cookies.delete(:auth_token)
      session[:auth_token] = nil
    end
  end

  def update
    invitation = Invitation.where(:invited_id => @collaborator.id, :book_id => @book.id).first
    if @collaborator.password_reset_sent_at < 2.hours.ago
      redirect_to root_path, :notice => "O link já expirou. Por favor, peça ao organizador do livro para enviar um novo convite."
    elsif @collaborator.update_attributes(params[:user]) and invitation.present?
      @book.users << @collaborator
      invitation.destroy
      session[:auth_token] = @collaborator.auth_token
      redirect_to app_home_path, :notice => "Você foi adicionado como colaborador do livro <em>#{@book.title}</em>." and return
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
    @collaborator = User.find_by_password_reset_token!(params[:id])
  end
end
