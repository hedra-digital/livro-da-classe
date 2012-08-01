class Book < ActiveRecord::Base
  attr_accessible :title, :school_id

  belongs_to :school
  has_many :assignments
  has_many :texts, through: :assignments

end