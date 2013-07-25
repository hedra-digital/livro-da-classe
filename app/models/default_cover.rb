class DefaultCover < ActiveRecord::Base
  # attr_accessible :title, :body
  has_attached_file :default_cover, :styles => {:thumb => "100x100"}
  attr_accessible :default_cover
end
