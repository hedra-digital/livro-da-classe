class Expression < ActiveRecord::Base
  attr_accessible :replace, :target

  validates                 :target,     :presence => true
end
