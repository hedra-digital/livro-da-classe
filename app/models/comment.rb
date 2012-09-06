class Comment < ActiveRecord::Base
  attr_accessible :author, :content, :text_id

  belongs_to :text
  
end
