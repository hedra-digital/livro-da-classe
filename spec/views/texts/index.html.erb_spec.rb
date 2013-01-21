require 'spec_helper'

describe "texts/index" do
  before(:each) do
    @texts = [create(:text), create(:text)]
    @book = @texts.first.book
  end

  it "renders a list of texts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
