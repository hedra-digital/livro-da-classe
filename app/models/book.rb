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

    texts.order("position ASC").map(&builder).join
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
    require 'open-uri'
    begin
      site_url = "http://#{Livrodaclasse::Application.config.action_mailer.default_url_options[:host]}"
      site_url = "#{site_url}/books/#{self.uuid}.pdf"
      reader = PDF::Reader.new(open(site_url))
      reader.page_count
    rescue
      0
    end
  end

  private

  def set_uuid
    self.uuid = Guid.new.to_s if self.uuid.nil?
  end

end
