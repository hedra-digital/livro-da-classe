require 'spec_helper'

describe "books/show" do
  before(:each) do
    @book = create(:book)
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
