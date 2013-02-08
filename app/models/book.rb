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
  before_save           :set_uuid

  # Relationships
  belongs_to            :organizer, :class_name => "User"
  has_many              :collaborators, :through => :collaborations, :class_name => "User"
  has_many              :collaborations
  has_many              :texts

  # Validations
  validates             :organizer, :presence => true
  validates             :title,     :presence => true

  # Specify fields that can be accessible through mass assignment
  attr_accessible       :coordinators, :directors, :organizers, :published_at, :subtitle, :title, :uuid, :organizer, :text_ids

  attr_accessor         :finished_at

  def self.find_by_uuid_or_id(id)
    response   = Book.find_by_uuid(id.to_s)
    response ||= Book.find_by_id(id)
    return response
  end

  private

  def set_uuid
     self.uuid = Guid.new.to_s if self.uuid.nil?
  end
end
