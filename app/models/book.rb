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
  attr_accessible           :project_attributes, :cover_info_attributes, :coordinators, :directors, :organizers, :published_at, :subtitle, :title, :uuid, :organizer, :organizer_id, :text_ids, :users, :template, :cover, :institution, :street, :number, :city, :state, :zipcode, :klass, :librarian_name, :cdd, :cdu, :keywords

  attr_accessor             :finished_at

  accepts_nested_attributes_for :cover_info, :project

  # Paperclip attachment
  has_attached_file :cover,
                    :styles => {
                      :content => ['100%', :jpg],
                      :thumb => ['60x80>', :jpg]
                    }

  # Other methods
  def self.find_by_uuid_or_id(id)
    response   = Book.find_by_uuid(id.to_s)
    response ||= Book.find_by_id(id)
    return response
  end

  def full_text_latex
    require "#{Rails.root}/lib/markup_latex.rb"

    builder = proc do |text|
      "\\chapter{#{text.title}}\n#{MarkupLatex.new(text.content).to_latex}\n" unless text.content.to_s.size == 0
    end

    t = texts.order("-position DESC").map(&builder).join
    t.gsub("\n\\\\","\n")
    t.gsub("\\\\","\n\n")
    t.gsub("\\ \\","\n\n")
    t
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

  #def create_dependencies
  #  CoverInfo.create(book_id: self.id)
  #  Project.create(book_id: self.id) 
  #end

  def commands
    commands = ""
    commands << "\\newcommand{\\nucleo}[3]{\\chapter{#1,por #2}{#1}\\par\\hfill#2\\medskip\\par#3}\n"
    commands << "\\newcommand{\\logoescola}{#{self.get_school_logo}}\n"
    commands << "\\newcommand\\titulo{#{self.title}}\n"
    commands << "\\newcommand\\autor{#{self.organizer.name}}\n"
    commands << "\\newcommansd\\organizador{#{self.organizers}}\n"
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
    commands << "\n\\input{#{self.template}/LIVRO}\n"
    commands
  end

  def content
    content = ""
    self.texts.each do |text|
      content << "\\begin{nucleo}{#{text.title}}[#{text.author}][#{text.default_image}]#{text.content}\\end{nucleo}\n\n"
    end
    content
  end

  def pdf
    config = {:command => 'pdflatex', :arguments => ['-halt-on-error']}

    directory = File.join(Rails.root,'tmp','rails-latex',"#{self.id}-#{self.title}")
    input_text = File.join(directory,'TEXTO.tex')
    input_comands = File.join(directory,'comandosespecificos.sty')
    FileUtils.mkdir_p(directory)

    # write commands file
    File.open(input_comands,'wb') {|io| io.write(self.commands) }

    # write core file
    File.open(input_text,'wb') {|io| io.write(self.content) }

    # build latex
    Process.waitpid(
      fork do
        begin
          Dir.chdir directory
          STDOUT.reopen("TEXTO.log","a")
          STDERR.reopen(STDOUT)
          args = config[:arguments] + %w[-shell-escape -interaction batchmode TEXTO.tex]
          system config[:command], '-draftmode', *args
          exec config[:command], *args
        rescue
          File.open("TEXTO.log",'a') {|io|
            io.write("#{$!.message}:\n#{$!.backtrace.join("\n")}\n")
          }
        ensure
          Process.exit! 1
        end
      end
    )

    # check rotine success
    if File.exist?(pdf_file = input_text.sub(/\.tex$/,'.pdf'))
      File.rename(pdf_file, File.join(directory,'SUCESSO.pdf'))
      pdf_file = File.join(directory,'SUCESSO.pdf')
      #result = File.read(pdf_file)
    else
      pdf_file = nil
      #send email with .log attached
      AdminMailer.pdf_to_latex_error(self, directory, "#{input_text.sub(/\.tex$/,'.log')}").deliver
      #showing last success (if not exists shows an error)
      #pdf_file = File.join(directory,'SUCESSO.pdf')
      #result = File.read(pdf_file)
    end
    pdf_file
  end
  
  private

  def set_uuid
    self.uuid = Guid.new.to_s if self.uuid.nil?
  end
end