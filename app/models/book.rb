class Book < ActiveRecord::Base
	attr_accessible :published_at, :title, :text_ids, :uuid
	has_and_belongs_to_many :texts
	belongs_to :school, :inverse_of => :books

	before_save :set_uuid

	def to_label
		"#{title} (#{texts.count})"
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