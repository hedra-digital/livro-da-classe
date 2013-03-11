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

  context "when saving and a release date is set" do
    it "should accept only dates in the future" do
      project = build(:project, :release_date => Date.yesterday)
      project.should_not be_valid
      project.should have(1).error_on(:release_date)
    end

    it "should not accept dates before interval set by PROJECT::MANUFACTURE_TIME" do
      project = build(:project, :release_date => Date.tomorrow)
      project.should_not be_valid
      project.should have(1).error_on(:release_date)
    end

    it "should accept dates before interval set by PROJECT::MANUFACTURE_TIME" do
      project = build(:project, :release_date => (Date.tomorrow + Project::MANUFACTURE_TIME + 10.days))
      project.should be_valid
      project.should_not have(1).error_on(:release_date)
    end
  end

  context ".finish_date" do
    it "should return nil if no release date is set" do
      project = build(:project, :release_date => nil)
      project.finish_date.should be_nil
    end

    it "should return the release date minus the MANUFACTURE_TIME if release date is set" do
      project = build(:project, :release_date => (Date.tomorrow + Project::MANUFACTURE_TIME + 10.days))
      project.finish_date.should == (Date.tomorrow + 10.days)
    end
  end

  context ".remaining_days" do
    it "should calculate the number of dates between today and the finish_date" do
      release_date = (Date.tomorrow + Project::MANUFACTURE_TIME + 10.days)
      project = build(:project, :release_date => (Date.tomorrow + Project::MANUFACTURE_TIME + 10.days))
      project.remaining_days.should  == (project.release_date - Date.today ).to_i
    end

    it "should never be negative" do
      project = build(:project, :release_date => (Date.yesterday))
      project.remaining_days.should >= 0
    end
  end
end
