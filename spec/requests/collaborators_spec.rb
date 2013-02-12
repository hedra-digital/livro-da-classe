require 'spec_helper'

describe "Collaborators" do
  describe "GET /books/:id/collaborators" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      book = create(:book)
      get book_collaborators_path(book)
      response.status.should be(302)
    end
  end
end
