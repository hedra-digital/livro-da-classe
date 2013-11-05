class Expression < ActiveRecord::Base
  attr_accessible :replace, :target

  validates                 :replace, :presence => true
  validates                 :target,     :presence => true
end
