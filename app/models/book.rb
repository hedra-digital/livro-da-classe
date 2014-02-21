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
  
  # Relationships
  belongs_to                :organizer, :class_name => "User", :foreign_key => "organizer_id"
  has_and_belongs_to_many   :users
  has_many                  :texts, :dependent => :destroy
  has_one                   :project, :dependent => :destroy
  has_one                   :cover_info
  has_one                   :book_data
  has_many                  :invitations, :dependent => :destroy
  has_many                  :scraps, :dependent => :destroy

  # Validations
  validates                 :organizer, :presence => true
  validates                 :title,     :presence => true
  validates                 :number,    :numericality => true, :allow_blank => true

  # Specify fields that can be accessible through mass assignment
  attr_accessible           :project_attributes, :cover_info_attributes, :book_data, :coordinators, :directors, :organizers, :published_at, :title, :subtitle, :uuid, :organizer, :organizer_id, :text_ids, :users, :template, :cover, :institution, :street, :number, :city, :state, :zipcode, :klass, :librarian_name, :cdd, :cdu, :keywords, :document, :publisher_id, :abstract, :valid_pdf, :pages_count

  attr_accessor             :finished_at

  accepts_nested_attributes_for :cover_info, :project, :book_data

  # Paperclip attachment
  has_attached_file :cover,
                    :url => "/system/:class/:attachment/:id_partition/:style/Capa.:extension",
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

  def resize_images?
    self.cover_info.capa_imagem.present? or self.cover_info.capa_detalhe.present?
  end

  def pdf user_profile=nil
    #check repository existence
    self.check_repository

    # generate latex files
    input_files = ""
    self.texts.order("-position DESC").each do |text|
      text.to_file
      input_files << "\\input{#{text.short_filename}}\n"
    end

    input_text = File.join(directory,'INPUTS.tex')
    File.open(input_text,'w') {|io| io.write(input_files) }

    input_commands = File.join(directory,'fichatecnica.sty')
    File.open(input_commands,'w') {|io| io.write(self.book_data.to_file) }

    # generate pdf
    Process.waitpid(
      fork do
        begin
          system "cd #{directory}/ && make"
        rescue
          system "cd #{directory}/ && make clean"
        ensure
          Process.exit! 1
        end
      end
    )

    # check rotine success
    if File.exist?(pdf_file = File.join(directory, 'LIVRO.pdf'))
      File.rename(pdf_file, File.join(directory,"#{self.uuid}.pdf"))
      pdf_file = File.join(directory,"#{self.uuid}.pdf")
      pages = PDF::Reader.new(pdf_file).page_count

      self.update_attributes(:valid_pdf => true, :pages_count => pages)
    else
      pdf_file = nil
      if File.exist?(File.join(directory, 'LIVRO.log'))
        AdminMailer.pdf_to_latex_error(self, directory, "#{directory}/LIVRO.log").deliver
      end
      self.update_attributes(:valid_pdf => false)
    end
    pdf_file
  end

  def valid
    self.valid_pdf
  end

  def directory
    File.join(CONFIG[Rails.env.to_sym]["books_path"],directory_name)
  end

  def autor
    self.book_data.nil? or self.book_data.autor.blank? ? "" : "#{String.remover_acentos(self.book_data.autor).gsub(/[^0-9A-Za-z]/, '')}-"
  end

  def directory_name
    "#{self.autor}#{String.remover_acentos(self.title).gsub(/[^0-9A-Za-z]/, '')}-#{self.template}-#{self.id}"
  end

  def check_repository
    if !self.book_data.nil? && !Dir.exists?(directory)
      template_directory = File.join(CONFIG[Rails.env.to_sym]["latex_template_path"],"#{self.template}","*")
      p template_directory
      FileUtils.mkdir_p(directory)
      FileUtils.cp_r(Dir[template_directory], directory)
      Version.commit_directory directory, "New Book => #{self.title}", directory_name
    end
  end

  private

  def set_uuid
    self.uuid = Guid.new.to_s if self.uuid.nil?
  end
end