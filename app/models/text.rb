# == Schema Information
#
# Table name: texts
#
#  id         :integer          not null, primary key
#  book_id    :integer
#  content    :text
#  title      :string(255)
#  uuid       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  position   :integer
#  user_id    :integer
#

class Text < ActiveRecord::Base

  # Callbacks
  # http://guides.rubyonrails.org/v3.2.9/active_record_validations_callbacks.html#available-callbacks
  before_save               :set_uuid
  before_save               :remove_expressions
  before_save               :set_positoin

  after_create              :create_file
  after_update              :update_file
  after_destroy             :delete_file

  # Relationships
  belongs_to                :book
  belongs_to                :user
  has_many                  :comments

  # Validations
  validates :book_id,       :presence => true
  validates :title,         :presence => true
  validates :user_id,       :presence => true

  # Specify fields that can be accessible through mass assignment
  attr_accessible           :book_id, :content, :title, :subtitle, :uuid, :user_id, :enabled, :author, :image, :valid_content, :revised, :git_message

  attr_accessor             :git_message

  has_attached_file :image,
  :styles => {
    :normal => ["600x600>", :png],
    :small => ["300x300>", :png]
  }

  attr_accessor             :finished_at

  def self.find_by_uuid_or_id(id)
    response   = Text.find_by_uuid(id.to_s)
    response ||= Text.find_by_id(id)
    return response
  end

  def is_enabled?
    self.enabled
  end

  def default_image
    self.image.exists? ? '' : self.image.path
  end

  def to_file
    content = LatexConverter.to_latex(self.content_with_head)
    File.open(self.filename,'wb') {|io| io.write(content) }
  end

  def validate_content
    begin
      LatexConverter.to_latex(self.content)
      return true
    rescue
      return false
    end
  end

  # file name with full dir
  def filename
    File.join(self.book.directory,short_filename)
  end

  def short_filename
    "#{String.remover_acentos(self.title).gsub(/[^0-9A-Za-z]/, '').upcase}#{self.id}.tex"
  end

  def short_filename_was
    "#{String.remover_acentos(self.title_was).gsub(/[^0-9A-Za-z]/, '').upcase}#{self.id}.tex"
  end

  def content_with_head
    "<section data-id='#{self.uuid}' class=\"chapter\"><h1>#{self.title}</h1><h3>#{self.subtitle}</h3><p>#{self.author}</p></section>#{self.content}"
  end

  def content_with_h1_head
    "<h1 data-id='#{self.uuid}'>#{self.title}</h1>#{self.content}"
  end

  def self.split_chpaters(content)
    doc = Nokogiri::HTML(content)

    footnotes = doc.css("div.sdfootnotesym").remove

    chapters = []
    current_chapter = [] # current chapter is a html nodes arrary

    doc.css('body > *').each do |level_1_node|
      if (level_1_node.node_name == "section" and level_1_node.attribute("class").value == "chapter") or level_1_node.node_name == "h1"

        chapters << current_chapter if current_chapter.count > 0
        current_chapter = []
      end

      current_chapter << level_1_node
    end
    # add the last chapter
    chapters << current_chapter if current_chapter.count > 0

    [chapters, footnotes]
  end

  def self.save_split_chapters(chapters, footnotes, book, current_user)
    chapter_ids = []
    chapters.each do |chapter|

      # chapter's first node must be "section" or "h1"
      chapter_node = chapter.shift 

      if chapter_node.attribute("data-id")
        text = Text.find_by_uuid(chapter_node.attribute("data-id").value)
      else
        text = Text.new
        text.book = book
        text.user = current_user
      end

      if chapter_node.node_name == "section"
        text.title = chapter_node.at_css("h1").text
        text.subtitle = chapter_node.at_css("h3").text if chapter_node.at_css("h3")
        text.author = chapter_node.at_css("p").text if chapter_node.at_css("p")
      else
        # for h1
        text.title = chapter_node.content
      end

      text.content = chapter.map(&:to_html).join()

      # find the chapter footnotes and append to chapter
      Nokogiri::HTML(text.content).css("a.sdfootnoteanc").each do |footnote_link|
        data_id = footnote_link.attr("data-id")

        matched_node = nil
        
        footnotes.each do |footnote|
          if(footnote.attr("data-id") == data_id)
            text.content += footnote.to_html()
            matched_node = footnote
          end
        end
        # do not delete in loop
        footnotes.delete matched_node if matched_node
      end


      text.valid_content = text.validate_content
      text.title = "Título do capítulo" if text.title.blank? # fixed for some blank h1
      text.save

      # after save, the new chapter have id
      chapter_ids << text.id
      # TODO add git support
      # TODO this will create more text in db, and delete it. if save it many times. because do not give the new data id to new text
    end
    chapter_ids
  end

  # in this way, we can save it for many times without the wrong position
  def self.set_positoins_after_split(chapter_ids)

    current_chapter_id = chapter_ids.shift
    current_book_id = Text.find(current_chapter_id).book_id

    chapters = Text.where(:book_id => current_book_id).order("position")
    book_chapter_ids = []
    chapters.each do |c|
      book_chapter_ids << c.id
    end

    # remove the new chapter ids
    book_chapter_ids = book_chapter_ids - chapter_ids

    # add the new chapter ids in the right position
    book_chapter_ids.insert((book_chapter_ids.index(current_chapter_id) + 1), *chapter_ids)

    # set the right position to all chapters in this book    
    book_chapter_ids.each_with_index do |id, index|
      chapter = Text.find(id)
      chapter.position = index + 1
      chapter.save
    end

  end

  private

  def set_uuid
    self.uuid = Guid.new.to_s if self.uuid.nil?
  end

  # set the default positoin
  def set_positoin
    self.position = self.book.texts.count + 1 unless self.position
  end

  def create_file
    self.to_file
    system <<-command
    cd #{self.book.directory}
    git add #{self.filename}
    git commit -m "add chapter #{self.title}"
    command
  end

  def update_file
    if self.title_changed?
      system <<-command
      cd #{self.book.directory}
      git mv #{self.short_filename_was} #{self.short_filename}
      git commit -m "rename chapter #{self.title_was}"
      command
    end

    self.to_file

    system <<-command
    cd #{self.book.directory}
    git add #{self.short_filename}
    git commit -m "update chapter #{self.title}"
    command
  end

  def delete_file
    system <<-command
    cd #{self.book.directory}
    git rm #{self.filename}
    git commit -m "delete chapter #{self.title}"
    command
  end

  def remove_expressions
    Expression.where(:level => 1).each do |exp|
      self.content = self.content.gsub(eval(exp.target), exp.replace)
    end

    if revised
      Expression.where(:level => 2).each do |exp|
        self.content = self.content.gsub(eval(exp.target), "<span style='background-color:#FFD700;'>#{exp.replace}</span>")
      end
    end
  end

end