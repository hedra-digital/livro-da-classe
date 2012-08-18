class Text < ActiveRecord::Base
	attr_accessible :content, :title, :book_ids
	has_and_belongs_to_many :books
	has_and_belongs_to_many :person

	before_save :set_uuid

	def to_label
		"#{title}"
	end

	def self.find(id)
		response   = Book.find_by_uuid(id.to_s)
		response ||= Book.find_by_id(id)
		return response
	end
	
	private

	def set_uuid
		 self.uuid = Guid.new.to_s if self.uuid.nil?
	end

end