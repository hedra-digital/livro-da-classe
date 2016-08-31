require 'spec_helper'

describe BookData do
	context 'creates a valid book data' do
		it 'ignores renames dir without book' do
			book_data = BookData.create(autor: 'Fake author')
			expect(book_data.errors).to be_empty
		end

		it 'renames dir on create with book' do
			book = FactoryGirl.create(:book)
			book_data = BookData.create(autor: 'Fake author')
			book_data.book = book
			book_data.autor = 'Change author'
			book_data.save
			expect(book_data.errors).to be_empty
		end
	end
end