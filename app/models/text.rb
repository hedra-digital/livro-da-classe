class Text < ActiveRecord::Base
	attr_accessible :content, :title, :book_ids
	has_and_belongs_to_many :books
	has_and_belongs_to_many :person

	def to_label
		"<em>#{title}</em>"
	end

end
