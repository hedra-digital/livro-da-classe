class Book < ActiveRecord::Base
  attr_accessible :published_at, :title
  has_and_belongs_to_many :texts
  belongs_to :school, :inverse_of => :books
end
