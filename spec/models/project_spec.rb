# == Schema Information
#
# Table name: projects
#
#  id           :integer          not null, primary key
#  book_id      :integer
#  release_date :date
#  finish_date  :date
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  client_id    :integer
#

require 'spec_helper'

describe Project do
  it { should respond_to(:book_id) }
  it { should respond_to(:release_date) }
  it { should respond_to(:finish_date) }
  it { should respond_to(:client_id) }

  context "when validating" do
    it "is invalid without a book_id" do
      project = build(:project, :book_id => nil)
      project.should_not be_valid
      project.should have(1).error_on(:book_id)
    end
  end

  context "when saving" do
    it "should belong to a book" do
      project = create(:project, :book => build_stubbed(:book))
      project.book.should_not be_nil
      project.book.should be_an_instance_of(Book)
    end
  end
end
