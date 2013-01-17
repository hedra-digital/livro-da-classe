require 'spec_helper'

describe Text do
  it { should respond_to(:book_id) }
  it { should respond_to(:content) }
  it { should respond_to(:title) }
  it { should respond_to(:uuid) }
  it { should respond_to(:content) }


  context 'when validating' do
    it 'is invalid without a book_id' do
      text = build(:text, :book_id => nil)
      text.should_not be_valid
      text.should have(1).error_on(:book_id)
    end 
  end

  context 'when saving' do
    it 'should belongs to a book' do
      text = create(:text)
      text.book.should_not be_nil
      text.book.should be_an_instance_of(Book)
    end    
  end
end
