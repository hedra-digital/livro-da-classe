class Text < ActiveRecord::Base
  attr_accessible :book_id, :content, :title, :uuid, :content
  belongs_to :book
  
  validates :book_id, :presence => true
end
