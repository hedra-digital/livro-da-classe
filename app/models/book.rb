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

      # at the last 11 line of the log file
      # if start with " (./LIVRO.aux", means pdf is ok
      # the last 11 line may look like:
      # (./LIVRO.aux (./TESTE.aux)) ) 
      # (./LIVRO.aux (./INPUTS.aux)) ) 
      # (./LIVRO.aux (./INPUTS.aux) (./PUBLICIDADE.aux)) ) 
      # sometime, this line is not in the 11th.
      log_valid = false
      [9, 10, 11].each do |n|
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

  def ebook is_kindle=false
    # generate latex files
    self.generate_latex_files

    # generate ebook
    if is_kindle
      Process.waitpid(
        fork do
          begin
            system "cd #{directory}/ebook/ && make mobi"
          rescue
            system "cd #{directory}/ebook/ && make clean"
          ensure
            Process.exit! 1
          end
        end
        )
      # check rotine success
      if File.exist?(ebook_file = File.join(directory, 'ebook', 'EBOOK.idv'))
        File.rename(ebook_file, File.join(directory, 'ebook',"#{self.uuid}.idv"))
        ebook_file = File.join(directory, 'ebook', "#{self.uuid}.idv")
      else
        ebook_file = nil
      end
    else
      Process.waitpid(
        fork do
          begin
            system "cd #{directory}/ebook/ && make"
          rescue
            system "cd #{directory}/ebook/ && make clean"
          ensure
            Process.exit! 1
          end
        end
        )
      # check rotine success
      if File.exist?(ebook_file = File.join(directory, 'ebook', 'EBOOK.epub'))
        File.rename(ebook_file, File.join(directory, 'ebook',"#{self.uuid}.epub"))
        ebook_file = File.join(directory, 'ebook', "#{self.uuid}.epub")
      else
        ebook_file = nil
      end
    end
    
    ebook_file
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
    "#{Rails.env}-#{self.autor(autor_params)}#{String.remover_acentos(self.title).gsub(/[^0-9A-Za-z]/, '')}-#{self.template}-#{self.id}"
  end

  def directory_name_was
    "#{Rails.env}-#{self.autor_was}#{String.remover_acentos(self.title_was).gsub(/[^0-9A-Za-z]/, '')}-#{self.template_was}-#{self.id}"
  end

  def template_directory
    File.join(CONFIG[Rails.env.to_sym]["latex_template_path"],"#{self.template}")
  end

  def check_repository
    if !self.book_data.nil? && !Dir.exists?(directory)

      Thread.new do
        system <<-command
        curl --user #{CONFIG[Rails.env.to_sym]["git_user_pass"]} https://api.bitbucket.org/1.0/repositories/ --data name=#{directory_name} --data is_private=true

        mkdir #{directory}
        cp -r #{template_directory}/* #{directory}
        cp config/book_gitignore #{directory}/.gitignore
        cd #{directory}
        git init 
        git remote add origin #{CONFIG[Rails.env.to_sym]["git"]}/#{directory_name}.git 
        git add . 
        git commit -a -m "create book: #{self.title}"
        git push -u origin master

        command

        ActiveRecord::Base.connection.close
      end
    end
  end

  def rename_dir
    if(!self.new_record? and self.title_changed?)
      system "mv #{self.directory_was} #{self.directory}"
      self.rename_in_bitbucket
    end
  end 

  def change_template
    if(!self.new_record? and self.template_changed?)
      system "mv #{self.directory_was} #{self.directory}"
      system "cp -r #{template_directory}/* #{directory}"
      self.rename_in_bitbucket
    end
  end

  def rename_in_bitbucket
    bitbucket = BitBucket.new basic_auth: CONFIG[Rails.env.to_sym]["git_user_pass"]
    bitbucket.repos.edit CONFIG[Rails.env.to_sym]["bitbucket_user"], self.directory_name_was, {:name => self.directory_name, :is_private => true, :no_public_forks => true}
  end

  def push_to_bitbucket
    system <<-command
    cd #{self.directory}
    git push
    command
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
  end

  def self.push_all_to_repository
    Book.all.each do |book|
      book.push_to_bitbucket
    end
  end

  private

  def set_uuid
    self.uuid = Guid.new.to_s if self.uuid.nil?
  end

end