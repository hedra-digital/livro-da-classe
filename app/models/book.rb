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

  # Relationships
  belongs_to                :organizer, :class_name => "User", :foreign_key => "organizer_id"
  has_and_belongs_to_many   :users
  has_many                  :texts
  has_one                   :project
  has_many                  :invitations

  # Validations
  validates                 :organizer, :presence => true
  validates                 :title,     :presence => true

  # Specify fields that can be accessible through mass assignment
  attr_accessible           :coordinators, :directors, :organizers, :published_at, :subtitle, :title, :uuid, :organizer, :organizer_id, :text_ids, :users, :template, :cover

  attr_accessor             :finished_at

  # Paperclip attachment
  has_attached_file :cover,
                    :styles => {
                      :content => ['100%', :jpg],
                      :thumb => ['60x80#', :jpg]
                    }

  # Other methods
  def self.find_by_uuid_or_id(id)
    response   = Book.find_by_uuid(id.to_s)
    response ||= Book.find_by_id(id)
    return response
  end

  def full_text_latex
    builder = proc do |text|
      "\\chapter{#{text.title}}\n#{text_to_latex(text.content)}\n" unless text.content.to_s.size == 0
    end

    texts.order("position ASC").map(&builder).join
  end

  private

  def set_uuid
     self.uuid = Guid.new.to_s if self.uuid.nil?
  end

  def text_to_latex(text)
    content_text = text.dup
    coder ||= HTMLEntities.new
    content_text = coder.decode(content_text)

    array = prepare_text content_text
    compiled_array = compile_latex array
    string = ""
    compiled_array.each{|a| string << a[1]}
    string
  end

  def compile_latex(array)
    array.each do |element|
      if element[0] == :html
        element[1] = HedraLatex.convert(Kramdown::Document.new(element[1], :input => 'html').root)[0]
      elsif element[0] == :latex
        element[1] = ActionView::Base.full_sanitizer.sanitize(element[1])
        #removing html tags of latex code
      end
    end
  end

  def prepare_text(text)
    l_begin = "{beginlatex}"
    l_end = "{endlatex}"
    start_index = 0
    array_text = []

    while !text.empty?
      start_latex = text.index(l_begin)
      if(start_latex.nil?)
        array_text << [:html, text[(start_index)..(text.size - 1)]]
        text[start_index..text.size - 1] = ""
      else
        end_latex = text.index(l_end)
        array_text << [:html, text[(start_index)..(start_latex - 1)]]
        array_text << [:latex, text[(start_latex + l_begin.size)..(end_latex - 1)]]
        text[(start_index)..(end_latex + l_end.size - 1)] = ""
      end 
    end
    array_text
  end
end
