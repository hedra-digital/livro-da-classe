class Book < ActiveRecord::Base
	attr_accessible :published_at, :title, :text_ids
	has_and_belongs_to_many :texts
	belongs_to :school, :inverse_of => :books

	def to_label
		"#{title} (#{texts.count})"
	end

end