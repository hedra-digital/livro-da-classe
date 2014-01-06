class Expression < ActiveRecord::Base
  attr_accessible :replace, :target, :level

  validates                 :target,     :presence => true
  validates                 :level, 	 :numericality => { :greater_than => 0, :less_than_or_equal_to => 3 }, :presence => true
end
