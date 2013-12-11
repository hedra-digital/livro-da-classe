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
  #after_create              :create_dependencies
  # Relationships
  belongs_to                :organizer, :class_name => "User", :foreign_key => "organizer_id"
  has_and_belongs_to_many   :users
  has_many                  :texts, :dependent => :destroy
  has_one                   :project
  has_one                   :cover_info
  has_many                  :invitations, :dependent => :destroy
  has_many                  :scraps, :dependent => :destroy

  # Validations
  validates                 :organizer, :presence => true
  validates                 :title,     :presence => true
  validates                 :number,    :numericality => true, :allow_blank => true

  # Specify fields that can be accessible through mass assignment
  attr_accessible           :project_attributes, :cover_info_attributes, :coordinators, :directors, :organizers, :published_at, :subtitle, :title, :uuid, :organizer, :organizer_id, :text_ids, :users, :template, :cover, :institution, :street, :number, :city, :state, :zipcode, :klass, :librarian_name, :cdd, :cdu, :keywords, :document, :publisher_id, :abstract

  attr_accessor             :finished_at

  accepts_nested_attributes_for :cover_info, :project

  # Paperclip attachment
  has_attached_file :cover,
                    :styles => {
                      :content => ['100%', :jpg],
                      :thumb => ['60x80>', :jpg]
                    }

  has_attached_file :document

  validates_attachment_size :document,
                            :less_than => 25.megabytes,
                            :message => "O tamanho limite do arquivo (25MB) foi ultrapassado"

  after_validation :join_document_errors

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

  def count_pages
    begin
      require 'open-uri'
      site_url = "http://#{Livrodaclasse::Application.config.action_mailer.default_url_options[:host]}"
      site_url = "#{site_url}/books/#{self.uuid}.pdf"
      reader = PDF::Reader.new(open(site_url))
      return reader.page_count
    rescue
      return 0
    end
  end

  def resize_images?
    self.cover_info.capa_imagem.present? or self.cover_info.capa_detalhe.present?
  end

  def commands
    commands = ""
    commands << "\\newcommand\\logoescola{#{self.get_school_logo}}\n"
    commands << "\\newcommand\\titulo{#{self.title}}\n"
    commands << "\\newcommand\\autor{#{self.organizer.name}}\n"
    commands << "\\newcommand\\organizador{#{self.organizers}}\n"
    commands << "\\newcommand\\tradutor{Tradutor}\n"
    commands << "\\newcommand\\cidade{São Paulo}\n"
    commands << "\\newcommand\\ano{2013}\n"
    commands << "\\newcommand\\direitos{Hedra}\n"
    commands << "\\newcommand\\introducao{\\chapter{Introdução}\\lipsum[1-4]}\n"
    commands << "\\newcommand\\instituicao{#{self.institution}}\n"
    commands << "\\newcommand\\logradouro{#{self.street}}\n"
    commands << "\\newcommand\\numero{#{self.number}}\n"
    commands << "\\newcommand\\cidadeinstituicao{#{self.city}}\n"
    commands << "\\newcommand\\estado{#{self.state}}\n"
    commands << "\\newcommand\\cep{#{self.zipcode}}\n"
    commands << "\\newcommand\\diretor{#{self.directors}}\n"
    commands << "\\newcommand\\coordenador{#{self.coordinators}}\n"
    commands << "\\newcommand\\turma{#{self.klass}}\n"
    commands << "\\newcommand\\quartacapa{#{self.cover_info.texto_quarta_capa}}\n"
    commands << "\\newcommand\\logo{#{self.get_school_logo}}\n"
    commands << "\\newcommand\\bibliotecario{#{self.librarian_name}}\n"
    commands << "\\newcommand\\cdd{#{self.cdd}}\n"
    commands << "\\newcommand\\cdu{#{self.cdu}}\n"
    commands << "\\newcommand\\palavraschave{#{self.keywords}}\n"
    commands
  end

  def content
    require "#{Rails.root}/lib/markup_latex.rb"

    content = ""
    self.texts.order("-position DESC").each do |text|
      content << "\\begin{nucleo}{#{text.title}}[#{text.author}][#{text.default_image}]#{MarkupLatex.new(text.content).to_latex}\\end{nucleo}\n\n" unless text.content.to_s.size == 0
    end

    content.html_safe
  end

  def pdf
    directory = File.join(Rails.root,'public','books',"#{self.id}-#{self.title}".gsub(" ","_"))
    template_directory = File.join(CONFIG[Rails.env.to_sym]["latex_template_path"],'')

    FileUtils.mkdir_p(directory)

    input_files = ""
    self.texts.order("-position DESC").each do |text|
      text_filename = "#{String.remover_acentos(text.title).gsub(/[^0-9A-Za-z]/, '').upcase}#{text.id}.tex"
      text.to_file(File.join(directory,text_filename))
      input_files << "\\input{#{text_filename}}\n"
    end

    input_text = File.join(directory,'INPUTS.tex')
    File.open(input_text,'wb') {|io| io.write(input_files) }

    input_commands = File.join(directory,'comandos.sty')
    File.open(input_commands,'wb') {|io| io.write(self.commands) }

    # build latex
    Process.waitpid(
      fork do
        begin
          system "cp #{template_directory}#{self.template}/* #{directory}/"
          system "cd #{directory}/ && make"
        rescue
          #
        ensure
          Process.exit! 1
        end
      end
    )

    # check rotine success
    if File.exist?(pdf_file = File.join(directory, 'LIVRO.pdf'))
      File.rename(pdf_file, File.join(directory,"#{self.uuid}.pdf"))
      pdf_file = File.join(directory,"#{self.uuid}.pdf")
    else
      pdf_file = nil
      AdminMailer.pdf_to_latex_error(self, directory, "#{directory}/LIVRO.log").deliver
    end
    pdf_file
  end

  private

  def set_uuid
    self.uuid = Guid.new.to_s if self.uuid.nil?
  end
end