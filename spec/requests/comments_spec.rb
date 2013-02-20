require 'spec_helper'

describe "Comments" do
  describe "GET /books/:id/texts/:id" do
    it "works!" do
      book = create(:book)
      text = create(:text, :book_id => book.id)
      get book_text_path(book.uuid, text.uuid)
      response.status.should be(302)
    end
  end
end
