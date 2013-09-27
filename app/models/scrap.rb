class Scrap < ActiveRecord::Base
  attr_accessible :book_id, :content
  belongs_to :book
end
