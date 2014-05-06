# encoding: UTF-8

class BooksController < ApplicationController
  before_filter :authentication_check, :except => [:show]
  before_filter :ominiauth_user_gate, :except => [:show]
  before_filter :secure_organizer_id, :only => [:create, :update]
  before_filter :resource, :only => [:show, :edit, :destroy, :update, :cover_info, :update_cover_info, :generate_cover, :revision, :generate_pdf, :ask_for_download_pdf, :download_pdf, :generate_ebook]

  require "#{Rails.root}/lib/book_cover.rb"

  def index
    redirect_to new_book_path if current_user.organized_books.empty? and current_user.books.empty?

    @books = []
    @books.concat(current_user.organized_books).concat(current_user.books).flatten
    @books.sort! { |a,b| a.directory_name.downcase <=> b.directory_name.downcase }
  end

  def cover_info
  end
  
  def update_cover_info
    if @book.cover_info.update_attributes(params[:cover_info])
      BookCover.new(@book.cover_info).generate_cover
      redirect_to book_path(@book.uuid), notice: 'Capa atualizada com sucesso'
    else
      render :edit
    end
  end

  def generate_cover
    pdf_file = BookCover.new(@book.cover_info).generate_pdf_cover
    
    respond_to do |format|
      format.pdf do |pdf|
        send_file pdf_file    
      end
    end
  end

  def show
    @scraps = Scrap.where(:parent_scrap_id => nil, :book_id => @book.id).order('created_at DESC').all
    respond_to do |format|
      format.html
    end
  end

  def generate_pdf
    pdf = @book.pdf
    pdf_path = pdf.to_s.gsub('public/','')
    if !pdf.nil?
      render :json => { :path => "#{request.protocol}#{request.host_with_port}/#{pdf_path}", :result => "success" }
    else
      pdf_path = File.join(@book.directory,"#{@book.uuid}.pdf").gsub('public', '')
      render :json => { :path => "#{request.protocol}#{request.host_with_port}/#{pdf_path}", :result => "fail" }
    end
  end

  # work around http://stackoverflow.com/questions/6019522/rails-3-how-to-send-file-in-response-of-a-remote-form-in-rails 
  def ask_for_download_pdf
    pdf = @book.pdf
    pdf_path = pdf.to_s.gsub('public/','')
    render :json => { :path => "#{request.protocol}#{request.host_with_port}/#{book_download_pdf_path(@book.uuid)}", :result => "success" }
  end

  def download_pdf
    send_file File.open(File.join(@book.directory,"#{@book.uuid}.pdf"))
  end

  def generate_ebook
    ebook = @book.ebook params[:kindle].present?
    ebook_path = ebook.to_s.gsub('public/','')
    if !ebook.nil?
      render :json => { :path => "#{request.protocol}#{request.host_with_port}/#{ebook_path}", :result => "success" }
    else
      ebook_path = params[:kindle].present? ? File.join(@book.directory,"ebook","#{@book.uuid}.idv").gsub('public', '') : File.join(@book.directory,"ebook","#{@book.uuid}.epub").gsub('public', '')
      render :json => { :path => "#{request.protocol}#{request.host_with_port}/#{ebook_path}", :result => "fail" }
    end
  end

  def new
    states
    @book = current_user.organized_books.new
    @book.build_project
    @book.build_cover_info
    @book.build_book_data
  end

  def create
    cover_info = params[:book][:book_data][:cover_info]
    params[:book][:book_data].delete :cover_info

    book_data = params[:book][:book_data]
    params[:book].delete :book_data

    @book = current_user.organized_books.new(params[:book].merge(:template => Livrodaclasse::Application.latex_templates[0]))
    
    @book.organizer = current_user
    @book.publisher_id = current_publisher

    if @book.save
      @book.create_project quantity: 50, status: BookStatus.all.first.id

      @book.build_cover_info
      @book.cover_info.update_attributes cover_info

      @book.build_book_data
      @book.book_data.update_attributes book_data

      BookCover.new(@book.cover_info).generate_cover

      if @book.resize_images?
        redirect_to book_cover_info_path(@book.uuid)
      else
        redirect_to book_path(@book.uuid), notice: t('book_created')
      end
    else
      @book.build_project
      @book.build_cover_info
      @book.build_book_data
      render :new
    end
  end

  def edit
    respond_to do |format|
      format.html
    end
  end

  def update
    cover_info = params[:book][:book_data][:cover_info]
    params[:book][:book_data].delete :cover_info

    book_data = params[:book][:book_data]
    params[:book].delete :book_data

    cover_info.delete :capa_imagem        if cover_info[:capa_imagem].blank? 
    cover_info.delete :capa_detalhe       if cover_info[:capa_detalhe].blank?
    cover_info.delete :texto_quarta_capa  if cover_info[:texto_quarta_capa].blank?

    @book.publisher_id = current_publisher
    
    if @book.update_attributes(params[:book]) and @book.cover_info.update_attributes(cover_info) and @book.book_data.update_attributes(book_data)    
      BookCover.new(@book.cover_info).generate_cover
      if @book.resize_images?
        redirect_to book_cover_info_path(@book.uuid)
      else
        redirect_to book_path(@book.uuid), notice: t('book_updated')
      end
    else
      render :edit
    end
  end

  def destroy
    @book.project.destroy
    @book.destroy
    redirect_to books_url
  end

  def revision
    @name = @book.directory_name
  end
  
  private

  def secure_organizer_id
    params[:book].delete(:organizer)
  end

  def resource
    @book = Book.find_by_uuid_or_id(params[:id])
  end

  def states
    @states = [["Acre", "AC"], ["Alagoas", "AL"], ["Amazonas", "AM"], ["Amapá", "AP"], ["Bahia", "BA"], ["Ceará", "CE"], ["Distrito Federal", "DF"], ["Espírito Santo", "ES"], ["Goiás", "GO"], ["Maranhão", "MA"], ["Minas Gerais", "MG"], ["Mato Grosso do Sul", "MS"], ["Mato Grosso", "MT"], ["Pará", "PA"], ["Paraíba", "PB"], ["Pernambuco", "PE"], ["Piauí", "PI"], ["Paraná", "PR"], ["Rio de Janeiro", "RJ"], ["Rio Grande do Norte", "RN"], ["Rondônia", "RO"], ["Roraima", "RR"], ["Rio Grande do Sul", "RS"], ["Santa Catarina", "SC"], ["Sergipe", "SE"], ["São Paulo", "SP"], ["Tocantins", "TO"]]
  end
end
