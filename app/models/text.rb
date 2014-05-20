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
  before_save               :set_uuid
  before_save               :remove_expressions

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
    self.book.check_repository
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

  def filename
    File.join(self.book.directory,short_filename)
  end

  def short_filename
    "#{String.remover_acentos(self.title).gsub(/[^0-9A-Za-z]/, '').upcase}#{self.id}.tex"
  end

  def content_with_head
    "<section data-id='#{self.uuid}' class=\"chapter\"><h1>#{self.title}</h1><h3>#{self.subtitle}</h3><p>#{self.author}</p></section>#{self.content}"
  end

  def self.split_chpaters(content)
    doc = Nokogiri::HTML(content)
    chapters = []
    current_chapter = [] # current chapter is a html nodes arrary

    doc.css('body > *').each do |level_1_node|
      if (level_1_node.node_name == "section" and level_1_node.attribute("class").value == "chapter")

        chapters << current_chapter if current_chapter.count > 0
        current_chapter = []
      end

      current_chapter << level_1_node
    end
    # add the last chapter
    chapters << current_chapter if current_chapter.count > 0

    chapters
  end

  def self.save_split_chapters(chapters)
    chapter_ids = []
    chapters.each do |chapter|

      # chapter's first node must be "section" or "h1"
      chapter_node = chapter.shift 

      if chapter_node.attribute("data-id")
        text = Text.find_by_uuid(chapter_node.attribute("data-id").value)
      else
        text = Text.new
        text.book = @book
        text.user = current_user
      end

      text.title = chapter_node.at_css("h1").text
      text.subtitle = chapter_node.at_css("h3").text
      text.author = chapter_node.at_css("p").text

      text.content = chapter.map(&:to_html).join()
      text.valid_content = text.validate_content
      text.save

      # after save, the new chapter have id
      chapter_ids << text.id
      # TODO add git support
    end
    chapter_ids
  end

  private

  def set_uuid
    self.uuid = Guid.new.to_s if self.uuid.nil?
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