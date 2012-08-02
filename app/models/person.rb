class Person < ActiveRecord::Base
  attr_accessible :name
  has_and_belongs_to_many :texts
  has_many :books, :through => :texts
end