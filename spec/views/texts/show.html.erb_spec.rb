require 'spec_helper'

describe "texts/show" do
  before(:each) do
    @text = create(:text) 
    @book = @text.book
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
