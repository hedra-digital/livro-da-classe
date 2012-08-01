class Assignment < ActiveRecord::Base
  attr_accessible :book_id, :text_id, :school_id

  belongs_to :book
  belongs_to :text
  belongs_to :school

end
