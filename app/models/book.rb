class Book < ActiveRecord::Base
  attr_accessible :coordinators, :directors, :organizers, :published_at, :subtitle, :title, :uuid, :organizer, :text_ids
  belongs_to :organizer, :class_name => "User"

  validates :organizer, :presence => true
  validates :title,     :presence => true

  before_save            :set_uuid

  has_many              :texts

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
