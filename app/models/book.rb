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
    require "#{Rails.root}/lib/markup_latex.rb"

    builder = proc do |text|
      "\\chapter{#{text.title}}\n#{MarkupLatex.new(text.content).to_latex}\n" unless text.content.to_s.size == 0
    end

    content = texts.order("position ASC").map(&builder).join
    
    if self.project.present?
      content += MarkupLatex.school_logo_latex(self.project.school_logo.url)
    else
      content += MarkupLatex.school_logo_latex("")
    end

    content
  end

  private

  def set_uuid
    self.uuid = Guid.new.to_s if self.uuid.nil?
  end

end
