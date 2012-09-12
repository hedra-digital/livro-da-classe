class Text < ActiveRecord::Base
	attr_accessor 						:author_name
	attr_accessible 					:content, :title, :book_ids, :author_name
	
	has_and_belongs_to_many 	:books
	has_and_belongs_to_many 	:person
	has_many 									:comments

	before_save 							:set_uuid
	before_save 							:create_author_if_required

	def to_label
		"#{title}"
	end

	def self.find_by_uuid_or_id(id)
		response   = Text.find_by_uuid(id.to_s)
		response ||= Text.find_by_id(id)
		return response
	end
	
	private

	def set_uuid
		 self.uuid = Guid.new.to_s if self.uuid.nil?
	end

	def create_author_if_required
		if self.author_name.present?
			self.person << Person.create(:name => self.author_name)
		end
	end

end