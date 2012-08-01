class Text < ActiveRecord::Base
  attr_accessible :author, :content, :title

  has_many :assignments
  has_many :books, through: :assignments
  
end