class DefaultCover < ActiveRecord::Base
  # attr_accessible :title, :body
  has_attached_file :default_cover
end
