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
  before_save               :title_on_content

  # Relationships
  belongs_to                :book
  belongs_to                :user
  has_many                  :comments

  # Validations
  validates :book_id,       :presence => true
  validates :title,         :presence => true
  validates :user_id,       :presence => true

  # Specify fields that can be accessible through mass assignment
  attr_accessible           :book_id, :content, :title, :uuid, :user_id, :enabled, :author, :image, :valid_content

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

  def to_file(file)
    require "#{Rails.root}/lib/markup_latex.rb"

    self.content = self.content.gsub(/ <\/(.*?)>/m, '</\1>&nbsp;')
    self.content = self.content.gsub(/<([a-z]+)> /m, '&nbsp;<\1>')
     
    content = "#{MarkupLatex.new(self.content).to_latex}".html_safe

    content = content.gsub("\n\\\\","\\\\\\\n") #para tabelas
    content = content.gsub("\\textsuperscript{}","") #para footnote
    content = content.gsub("\n\\footnote","\\footnote") #para footnote
    content = content.gsub("\n.\\footnote",".\\footnote") #para footnote

    Expression.where(:level => 3).each do |exp|
      content = content.gsub(eval(exp.target), exp.replace)
    end

    #content = content.gsub("\n\\\\","\n\n")
    #content = content.gsub("\\\\","\n\n")
    #content = content.gsub("\\ \\","\n\n")
    File.open(file,'wb') {|io| io.write(content) }
  end

  def self.validate_content
    true
  end

  private

  def set_uuid
     self.uuid = Guid.new.to_s if self.uuid.nil?
  end

  def remove_expressions
    Expression.where(:level => 1).each do |exp|
      self.content = self.content.gsub(eval(exp.target), exp.replace)
    end

    Expression.where(:level => 2).each do |exp|
      self.content = self.content.gsub(eval(exp.target), "<span style='background-color:#FFD700;'>#{exp.replace}</span>")
    end
  end

  def title_on_content
    if !self.new_record? and self.valid_content_changed? and self.valid_content_was.nil? 
      self.content = "<h1>#{self.title}</h1>#{self.content}"
    end
  end
end

