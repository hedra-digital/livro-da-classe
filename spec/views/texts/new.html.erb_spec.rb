require 'spec_helper'

describe "texts/new" do
  before(:each) do
    @text = create(:text)
    @book = @text.book
  end

  it "renders new text form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => book_texts_path(@text.book), :method => "post" do
    end
  end
end
