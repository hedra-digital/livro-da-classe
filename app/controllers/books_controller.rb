# encoding: UTF-8
require "#{Rails.root}/lib/google_connector.rb"
require "#{Rails.root}/lib/google_html.rb"

class BooksController < ApplicationController
  before_filter :authentication_check, except: [:show]
  before_filter :ominiauth_user_gate, except: [:show]
  before_filter :secure_organizer_id, only: [:create, :update]
  before_filter :resource, only: [:show, :edit, :destroy, :update, :cover_info, :update_cover_info, :generate_cover, :revision, :generate_pdf, :ask_for_download_pdf, :download_pdf, :generate_ebook, :epub_viewer, :rules, :rule_active]

  require "#{Rails.root}/lib/book_cover.rb"

  def index
    redirect_to new_book_path if current_user.organized_books.empty? && current_user.books.empty?

    @books = []
    @books.concat(current_user.organized_books).concat(current_user.books).flatten
    @books.sort! { |a, b| a.directory_name.downcase <=> b.directory_name.downcase }
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
      format.pdf do |_pdf|
        send_file pdf_file
      end
    end
  end

  def show
    redirect_to book_texts_path(@book.uuid)
  end

  def generate_pdf
    pdf = @book.pdf
    pdf_path = pdf.to_s.gsub('public/', '')
    if !pdf.nil?
      render json: { path: "#{request.protocol}#{request.host_with_port}/#{pdf_path}", result: 'success' }
    else
      pdf_path = File.join(@book.directory, "#{@book.uuid}.pdf").gsub('public', '')
      render json: { path: "#{request.protocol}#{request.host_with_port}/#{pdf_path}", result: 'fail' }
    end
  end

  # work around http://stackoverflow.com/questions/6019522/rails-3-how-to-send-file-in-response-of-a-remote-form-in-rails
  def ask_for_download_pdf
    pdf = @book.pdf
    pdf_path = pdf.to_s.gsub('public/', '')
    render json: { path: "#{request.protocol}#{request.host_with_port}/#{book_download_pdf_path(@book.uuid)}", result: 'success' }
  end

  def download_pdf
    filename = if @book.autor.blank?
                 "#{@book.title}.pdf"
               else
                 "#{@book.book_data.autor}-#{@book.title}.pdf"
               end
    send_file(File.open(File.join(@book.directory, 'LIVRO.pdf')), filename: filename)
  end

  def generate_ebook
    ebook = @book.ebook
    ebook_path = ebook.to_s.gsub('public/', '')
    if !ebook.nil?
      render json: { path: "#{request.protocol}#{request.host_with_port}/books/#{@book.uuid}/epub_viewer", result: 'success', new_window: true }
    else
      render json: { path: "#{request.protocol}#{request.host_with_port}/#{ebook_path}", result: 'fail' }
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

    template = params[:template].present? ? params[:template] : Livrodaclasse::Application.latex_templates[0]

    @book = current_user.organized_books.new(params[:book].merge(template: template))

    @book.organizer = current_user
    @book.publisher_id = current_publisher
    @book.acronym = get_acronym(params[:acronym]) if params[:acronym].present?

    if @book.save
      @book.create_project quantity: 100, status: BookStatus.all.first.id

      @book.build_cover_info
      @book.cover_info.update_attributes cover_info

      @book.build_book_data
      @book.book_data.update_attributes book_data

      BookCover.new(@book.cover_info).generate_cover

      if params[:upload].present?
        content = add_file_uploaded params[:upload]
        parse_new_content(content)
      end

      if params[:chapter].present?
        params[:chapter].each do |chapter|
          details = chapter.last
          logger.info 'waiting ...' until File.exist? @book.directory
          content = details[:file].present? ? add_file_uploaded(details[:file]) : ''
          create_text(details[:title], details[:subtitle], details[:author], content)
        end
      end

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
    rules
    @acronym = get_acronym_array
    respond_to do |format|
      format.html
    end
  end

  def update
    cover_info = params[:book][:book_data][:cover_info]
    params[:book][:book_data].delete :cover_info

    book_data = params[:book][:book_data]
    params[:book].delete :book_data

    @book.remove_capainteira unless book_data[:capainteira].present?
    @book.publisher_id = current_publisher
    @book.acronym = get_acronym(params[:acronym]) if params[:acronym].present?

    if params[:template].present? && params[:template] != @book.template
      params[:book].merge!(:template => params[:template])
    end

    if @book.update_attributes(params[:book]) && @book.cover_info.update_attributes(cover_info) && @book.book_data.update_attributes(book_data)
      @book.generate_originals_texts
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

  def epub_viewer
    render layout: false
  end

  def rule_active
    rule = Rule.find(params[:rule_id])
    maps = (@book.rules.map { |r| r if r.id == rule.id }).compact
    if maps.empty?
      @book.rules.push(rule)
    else
      @book.rules.delete(maps)
    end
    @book.save
    @book.generate_commands
    render json: { result: 'success' }
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

  def add_file_uploaded(file)
    connector = GoogleConnector.new

    upload = file
    filepath = Rails.root.join('/tmp', upload.original_filename)
    File.open(filepath, 'wb') do |file|
      file.write(upload.read)
    end
    google_filedocument_id = connector.upload(filepath.to_s)
    content = connector.download_as_html(google_filedocument_id)

    File.delete(filepath.to_s)
    GoogleHtml.validate_google_html(content)
  rescue Exception => e
    puts e.message
    puts e.backtrace.inspect
  end

  def parse_new_content(content)
    chapters, footnotes = Text.split_chpaters(content)
    chapter_ids = Text.save_split_chapters(chapters, footnotes, @book, current_user)

    Text.set_positoins_after_split(chapter_ids)
    @book.push_to_bitbucket
  end

  def rules
    @rules = []
    Rule.all.each do |rule|
      if rule.active
        map = (@book.rules.map { |r| r if r.id == rule.id }).compact
        @rules.push({ id: rule.id, label: rule.label, active: !map.empty? })
      end
    end
  end

  def get_acronym(obj)
    acronym_list_str = ''
    obj.each do |acronym|
      el = acronym.last
      acronym_list_str += el[:acronym] + '$$' + el[:desc] + '&&'
    end
    acronym_list_str
  end

  def get_acronym_array
    return [] unless @book.acronym.present?
    arr = []
    @book.acronym.split('&&').each do |line|
      arr_col = []
      line.split('$$').each do |col|
        arr_col.push(col)
      end
      arr.push(arr_col) unless arr_col.empty?
    end
    arr
  end

  def create_text(title, subtitle, author, content)
    text = Text.new
    text.title = title
    text.subtitle = subtitle
    text.author = author
    text.user = current_user
    text.book = @book
    text.valid_content = true
    text.content = content
    text.save
  end
end
