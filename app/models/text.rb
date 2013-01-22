class Text < ActiveRecord::Base
  attr_accessible :book, :content, :title, :uuid, :content
  belongs_to :book

  validates :book_id,     :presence => true
  validates :title,       :presence => true
  
  before_save             :set_uuid

  attr_accessor           :finished_at 

  def self.find_by_uuid_or_id(id)
    response   = Text.find_by_uuid(id.to_s)
    response ||= Text.find_by_id(id)
    return response
  end

  private

  def set_uuid
     self.uuid = Guid.new.to_s if self.uuid.nil?
  end
end
