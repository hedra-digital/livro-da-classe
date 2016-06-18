# encoding: UTF-8

# == Schema Information
#
# Table name: books
#
#  id           :integer          not null, primary key
#  published_at :datetime
#  title        :string(255)
#  uuid         :string(255)
#  subtitle     :string(255)
#  organizers   :text
#  directors    :text
#  coordinators :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  organizer_id :integer
#  template     :string(255)
#

class Book < ActiveRecord::Base

  # Callbacks
  before_save               :set_uuid
  after_save                :check_repository
  before_save               :rename_dir
  before_save               :change_template

  # Relationships
  belongs_to                :organizer, :class_name => "User", :foreign_key => "organizer_id"
  has_and_belongs_to_many   :users
  has_many                  :texts, :dependent => :destroy
  has_one                   :project, :dependent => :destroy
  has_one                   :cover_info
  has_one                   :book_data
  has_many                  :invitations, :dependent => :destroy
  has_many                  :scraps, :dependent => :destroy
  has_and_belongs_to_many   :rules

  # Validations
  validates                 :organizer, :presence => true
  validates                 :title,     :presence => true
  validates                 :number,    :numericality => true, :allow_blank => true

  # Specify fields that can be accessible through mass assignment
  attr_accessible           :project_attributes, :cover_info_attributes, :book_data, :coordinators, :directors, :organizers, :published_at, :title, :subtitle, :uuid, :organizer, :organizer_id, :text_ids, :users, :template, :cover, :institution, :street, :number, :city, :state, :zipcode, :klass, :librarian_name, :cdd,
                            :cdu, :keywords, :document, :publisher_id, :abstract, :valid_pdf, :pages_count, :dedic, :resume_original_text, :acknowledgment, :initial_cover, :acronym

  accepts_nested_attributes_for :cover_info, :project, :book_data

  # Paperclip attachment
  has_attached_file :cover,
  :url => "/system/:class/:attachment/:id_partition/:style/Capa.:extension",
  :styles => {
    :content => ['100%', :jpg],
    :thumb => ['60x80>', :jpg]
  }

  has_attached_file :initial_cover,
                    :url => "/system/:class/:attachment/:id_partition/:style/Front.:extension",
                    :styles => {
                      :content => ['100%', :jpg],
                      :thumb => ['60x80>', :jpg]
                    }
  validates_attachment_content_type :initial_cover, :content_type => /^image\/(jpg|jpeg|pjpeg|png|x-png|gif|svg\+xml)$/, :message => 'A imagem de abertur que você acrescentou parece que não está num formato adequado. Confira o formato e tente novamente.'

  has_attached_file :document

  validates_attachment_size :document,
  :less_than => 25.megabytes,
  :message => "O tamanho limite do arquivo (25MB) foi ultrapassado"

  after_validation :join_document_errors

  def get_school_logo
    if !self.project.nil?
      school_logo = self.project.school_logo.url
      if !school_logo.index("?").nil?
        school_logo = school_logo[0..school_logo.index("?") -1]
      end
      return Rails.public_path + school_logo
    else
      return Rails.public_path + "/default_logo.jpg"
    end
  end

  def join_document_errors
    if errors.messages.has_key?(:document_file_size)
      errors.messages[:document] = errors.messages[:document_file_size]
    end
  end

  # Other methods
  def self.find_by_uuid_or_id(id)
    response   = Book.find_by_uuid(id.to_s)
    response ||= Book.find_by_id(id)
    return response
  end

  def resize_images?
    self.cover_info.capa_imagem.present? or self.cover_info.capa_detalhe.present?
  end

  def has_ebook?
    File.directory? File.join(template_directory,"ebook")
  end

  def accessed_at
    self.texts.map(&:updated_at).sort.last if self.texts.count > 0
  end

  def pdf user_profile=nil
    # generate latex files
    self.generate_latex_files

    # generate pdf
    system "cd #{directory}/ && make"

    # check rotine success
    if File.exist?(pdf_file = File.join(directory, 'LIVRO.pdf'))
      pdf_file = File.join(directory, "LIVRO.pdf")
      pages = PDF::Reader.new(pdf_file).page_count
      self.update_attributes(:valid_pdf => true, :pages_count => pages)

      # at the last 11 line of the log file
      # if start with " (./LIVRO.aux", means pdf is ok
      # the last 11 line may look like:
      # (./LIVRO.aux (./TESTE.aux)) )
      # (./LIVRO.aux (./INPUTS.aux)) )
      # (./LIVRO.aux (./INPUTS.aux) (./PUBLICIDADE.aux)) )
      # sometime, this line is not in the 11th.
      log_valid = false
      [9, 10, 11, 12, 13, 14].each do |n|
        log_valid = (log_valid or File.readlines(directory + "/LIVRO.log").reverse[n].start_with?(" (./LIVRO.aux") )
      end

      if !log_valid
        AdminMailer.pdf_to_latex_error(self, directory, "#{directory}/LIVRO.log").deliver
        self.update_attributes(:valid_pdf => false)
      end

    else
      # should never run at here, need refactory
      pdf_file = nil
      if File.exist?(File.join(directory, 'LIVRO.log'))
        AdminMailer.pdf_to_latex_error(self, directory, "#{directory}/LIVRO.log").deliver
      end
      self.update_attributes(:valid_pdf => false)
    end
    pdf_file
  end

  def ebook
    book = GEPUB::Book.new
    book.set_primary_identifier('http:/www.hedra.com.br', self.uuid, 'URL')
    book.language = 'pt-BR'
    book.add_title(self.title, nil, GEPUB::TITLE_TYPE::MAIN).set_display_seq(1)
    book.add_creator(self.autor).set_display_seq(1)

    if self.book_data.capainteira.exists?
      imgfile = File.join(self.book_data.capainteira.path)
    else
      imgfile = File.join(self.cover.path)
    end
    File.open(imgfile) do
      |io|
      book.add_item('img/cover.png',io).cover_image
    end

    css_template = File.join('public/main-epub.css')
    File.open(css_template) do |io|
      book.add_item('css/main.css',io)
    end

    chapter_count = 1
    book.ordered {
      book.add_item('text/cover.xhtml').add_content(epub_cover)
      self.texts.each do |text|
        content = setup_footnote_epub(text.content)
        book.add_item("text/chap#{chapter_count}.xhtml").add_content(epub_chapter(text.title, content)).toc_text(text.title)
        chapter_count += 1
      end
    }
    epubname = File.join(directory, 'EBOOK.epub')

    book.generate_epub(epubname)
    epubname
  rescue
    nil
  end

  def valid
    self.valid_pdf
  end

  # full dir to the book
  # pass the autor to walk around bookdata in other table
  def directory(autor_params = self.book_data.autor)
    File.join(CONFIG[Rails.env.to_sym]["books_path"],directory_name(autor_params))
  end

  def directory_was
    File.join(CONFIG[Rails.env.to_sym]["books_path"],directory_name_was)
  end

  def autor(autor_params = self.book_data.autor)
    self.book_data.nil? or autor_params.blank? ? "" : "#{String.remover_acentos(autor_params).gsub(/[^0-9A-Za-z]/, '')}-"
  end

  def autor_was
    self.book_data.nil? or self.book_data.autor.blank? ? "" : "#{String.remover_acentos(self.book_data.autor).gsub(/[^0-9A-Za-z]/, '')}-"
  end

  # git dir name
  def directory_name(autor_params = self.book_data.autor)
    "#{CONFIG[Rails.env][:repo_prefix]}-#{self.autor(autor_params)}#{String.remover_acentos(self.title).gsub(/[^0-9A-Za-z]/, '')}-#{self.template}-#{self.id}"
  end

  def directory_name_was
    "#{CONFIG[Rails.env][:repo_prefix]}-#{self.autor_was}#{String.remover_acentos(self.title_was).gsub(/[^0-9A-Za-z]/, '')}-#{self.template_was}-#{self.id}"
  end

  def template_directory
    File.join(CONFIG[Rails.env.to_sym]["latex_template_path"],"#{self.template}")
  end

  def check_repository
    if !self.book_data.nil? && !Dir.exists?(directory)

      thr = Thread.new do
        logger.info `curl --user #{CONFIG[Rails.env]["git_user_pass"]} https://api.bitbucket.org/1.0/repositories/ --data name=#{CONFIG[Rails.env][:repo_prefix]}-#{self.uuid} --data is_private=true`

        sleep 1

        logger.info `mkdir #{directory}
        cp -r #{template_directory}/* #{directory}
        cp config/book_gitignore #{directory}/.gitignore
        cd #{directory}
        git init
        git remote add origin #{CONFIG[Rails.env]["git"]}/#{CONFIG[Rails.env][:repo_prefix]}-#{self.uuid}.git
        git add .
        git commit -a -m "create book: #{self.title}"
        git push -u origin master`

        ActiveRecord::Base.connection.close
      end

      thr.join
      generate_originals_texts
    end
  end

  def rename_dir
    if(!self.new_record? and self.title_changed?)
      logger.info `mv #{self.directory_was} #{self.directory}`

    end
  end

  def change_template
    if(!self.new_record? and self.template_changed?)

      logger.info `mv #{self.directory_was} #{self.directory}
      cp -r #{template_directory}/* #{self.directory}
      cd #{self.directory}
      git add .
      git commit -m "change template to #{self.template}"`

      self.push_to_bitbucket
    end
  end

  def rename_in_bitbucket
    bitbucket = BitBucket.new basic_auth: CONFIG[Rails.env.to_sym]["git_user_pass"]
    bitbucket.repos.edit CONFIG[Rails.env.to_sym]["bitbucket_user"], self.directory_name_was, {:name => self.directory_name, :is_private => true, :no_public_forks => true}
  end

  # push is very slow, must be in background
  def push_to_bitbucket
    Thread.new do
      logger.info `cd #{self.directory}
      git push`
      ActiveRecord::Base.connection.close
    end
  end

  def generate_latex_files
    input_files = ""
    self.texts.order("-position DESC").each do |text|
      text.to_file
      input_files << "\\input{#{text.short_filename}}\n"
    end

    input_text = File.join(directory,'INPUTS.tex')
    File.open(input_text,'w') {|io| io.write(input_files) }

    input_commands = File.join(directory,'fichatecnica.sty')
    File.open(input_commands,'w') {|io| io.write(self.book_data.to_file) }

    Thread.new do
      logger.info `cd #{self.directory}
      git add INPUTS.tex
      git add fichatecnica.sty
      git commit -m "add latex files"
      git push`

      ActiveRecord::Base.connection.close
    end
  end

  # just run for deploy
  def regenerate_git_repository
    logger.info `curl --user #{CONFIG[Rails.env]["git_user_pass"]} https://api.bitbucket.org/1.0/repositories/ --data name=#{CONFIG[Rails.env][:repo_prefix]}-#{self.uuid} --data is_private=true`

    sleep 1

    logger.info `mkdir #{directory}
    cp -r #{template_directory}/* #{directory}
    cp config/book_gitignore #{directory}/.gitignore
    cd #{directory}
    git init
    git remote add origin #{CONFIG[Rails.env]["git"]}/#{CONFIG[Rails.env][:repo_prefix]}-#{self.uuid}.git`

    input_files = ""
    self.texts.order("-position DESC").each do |text|
      text.to_file
      input_files << "\\input{#{text.short_filename}}\n"
    end

    input_text = File.join(directory,'INPUTS.tex')
    File.open(input_text,'w') {|io| io.write(input_files) }

    input_commands = File.join(directory,'fichatecnica.sty')
    File.open(input_commands,'w') {|io| io.write(self.book_data.to_file) }

    logger.info `cd #{self.directory}
    git add .
    git commit -a -m "regenerate git repository from database"
    git push -u origin master`

    logger.info "regenerate git repository from database for book, id #{self.id}"

  end

  def self.push_all_to_repository
    Book.all.each do |book|
      book.push_to_bitbucket
    end
  end

  def remove_capainteira
    self.book_data.remove_capainteira
  end

  def generate_commands
    Thread.new do
      logger.info 'Update commands.sty'
      input_commands = ''
      self.rules.each do |rule|
        if rule.active
          input_commands << "% #{rule.label}\n"
          input_commands << rule.command + "\n\n"
        end
      end
      File.open("#{self.directory}/commands.sty",'w') {|io| io.write(input_commands) }
    end
  end

  def generate_originals_texts
    arr = [ { part: 'DEDICATORIA', content: self.dedic },
            { part: 'RESUMO', content: self.resume_original_text },
            { part: 'AGRADECIMENTO', content: self.acknowledgment },
            { part: 'SIGLAS', content: self.acronym } ]
    arr.each do |element|
      # html
      content = element[:part] == 'SIGLAS' ? get_content_acronym(element[:content]) : element[:content]
      File.open("#{directory}/#{element[:part]}.html", 'w') { |io| io.write(content) }

      # tex
      begin
        content = LatexConverter.to_latex(content)
      rescue
        content = "Um erro aconteceu."
      end
      File.open("#{directory}/#{element[:part]}.tex",  'w') { |io| io.write(content) }

      #update repo
      tr = Thread.new do
        logger.info "Update #{element[:part]}"
        logger.info `cd #{directory}
        git add .
        git commit -a -m "Update #{element[:part]}"
        git push -u origin master`
        logger.info "Update #{element[:part]} for book, id #{id}"
      end
      tr.join
    end
    convert_initial_cover
  end

  private

  def set_uuid
    self.uuid = Guid.new.to_s if self.uuid.nil?
  end

  def epub_chapter(title, content)
    template = "<html xmlns='http://www.w3.org/1999/xhtml'>" +
                "<head>" +
                "<title>EBOOK</title>" +
                "<link href='../css/main.css' media='all' rel='stylesheet' type='text/css' />" +
                "</head>" +
                "<body>" +
                "<h1>#{title}</h1>" +
                "#{content}" +
                "</body></html>"
    StringIO.new(template)
  end

  def epub_cover
    template = "<html xmlns='http://www.w3.org/1999/xhtml'>" +
                "<head><title>COVER</title></head>" +
                "<body>" +
                "<div><svg xmlns='http://www.w3.org/2000/svg' height='100%' preserveAspectRatio='none' version='1.1' viewBox='0 0 601 942' width='100%' xmlns:xlink='http://www.w3.org/1999/xlink'><image height='942' width='601' xlink:href='../img/cover.png' /></svg>" +
                "</div>" +
                "</body></html>"
    StringIO.new(template)
  end

  def setup_footnote_epub(text)
    html = Nokogiri::HTML(text)
    div_notes = html.css 'a'
    count = 1
    div_notes.each do |a|
      if !a.attributes['class'].nil? && a.attributes['class'].value == 'sdfootnoteanc' && !a.css('sup').empty?
        a.attributes['data-id'].remove
        a['id'] = "sdfootnoteanc_#{count}"
        a['href'] = "#sdfootnotesym_#{count}"
        sup = a.css('sup').first
        sup.content = count
        count += 1
      end
    end

    count = 1
    divs = html.css 'div'
    divs.each do |div|
      if !div.attributes['class'].nil? && div.attributes['class'].value == 'sdfootnotesym'
        div.attributes['data-id'].remove
        content = div.content
        div.children.remove
        p_node = Nokogiri::XML::Node.new "p" , html
        sup = Nokogiri::XML::Node.new "sup", html
        link = Nokogiri::XML::Node.new "a", html
        link['id'] = "sdfootnotesym_#{count}"
        link['href'] = "#sdfootnoteanc_#{count}"

        sup.content = count

        sup.parent = link
        link.parent = p_node
        link.add_next_sibling content
        p_node.parent = div
        count += 1
      end
    end
    html.css('body').to_html
  end

  def convert_initial_cover
    if initial_cover_file_name.present?
      logger.info `cd #{directory}
      convert #{initial_cover.path} front.png
      git add .
      git commit -a -m "Update front.png"
      git push -u origin master`
      logger.info "Update front.png for book, id #{ id}"
    end
  end

  def get_content_acronym(table_html)
    return '' unless table_html.present?
    body = '<table>'
    tr = table_html.split('&&')
    tr.each do |tr_el|
      body += '<tr>'
      td = tr_el.split('$$')
      td.each do |td_el|
        body += '<td>' + td_el + '</td>'
      end
      body += '</tr>'
    end
    body += '</table>'
  end
end
