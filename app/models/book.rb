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
#

class Book < ActiveRecord::Base

  # Callbacks
  before_save               :set_uuid

  # Relationships
  belongs_to                :organizer, :class_name => "User", :foreign_key => "organizer_id"
  has_and_belongs_to_many   :users
  has_many                  :texts
  has_one                   :project

  # Validations
  validates                 :organizer, :presence => true
  validates                 :title,     :presence => true

  # Specify fields that can be accessible through mass assignment
  attr_accessible           :coordinators, :directors, :organizers, :published_at, :subtitle, :title, :uuid, :organizer, :organizer_id, :text_ids

  attr_accessor             :finished_at

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

    texts.map(&builder).join
  end

  private

  def set_uuid
     self.uuid = Guid.new.to_s if self.uuid.nil?
  end

  def text_to_latex(text)
    HedraLatex.convert(Kramdown::Document.new(text).root)[0]
  end

end
