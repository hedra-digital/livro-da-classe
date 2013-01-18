require 'spec_helper'

describe "books/index" do
  before(:each) do
    assign(:books, [
      create(:book),
      create(:book)
    ])
  end

  it "renders a list of books" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
