class Text < ActiveRecord::Base
  attr_accessible :content, :title
  has_and_belongs_to_many :books
  has_and_belongs_to_many :person
end
