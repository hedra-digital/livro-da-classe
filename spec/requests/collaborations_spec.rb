require 'spec_helper'

describe "Collaborations" do
  describe "GET /books/:id/collaborations" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers]
      book = create(:book)
      get book_collaborations_path(book)
      response.status.should be(200)
    end
  end
end
