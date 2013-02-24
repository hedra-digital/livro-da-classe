require 'spec_helper'

describe AuthorizationHelper do
  describe "is_organizer?" do
    it "returns false if @book is not set" do
      @current_user = create(:user)
      helper.is_organizer?.should be_false
      helper.is_organizer?.should_not be_nil
    end
    
    it "don't returns nil if @book is not set" do
      @current_user = create(:user)
      helper.is_organizer?.should_not be_nil
    end

    it "returns false if current_user is not set" do
      @book = create(:book)
      helper.is_organizer?.should be_false
    end

    it "don't returns nil if current_user is not set" do
      @book = create(:book)
      helper.is_organizer?.should_not be_nil
    end

    it "returns true if the current_user is the book organizer" do
      @book         = create(:book)
      @current_user = @book.organizer
      helper.is_organizer?.should be_true
    end

    it "returns false if the current_user isnt the book organizer" do
      @book         = create(:book)
      @current_user = create(:user)
      helper.is_organizer?.should be_false
    end

    it "should accept a book and an user as params" do
      book         = create(:book)
      user         = book.organizer
      expect { helper.is_organizer?(book, user) }.to_not raise_error
    end

    it "should return false if a book is passed but there's no current_user set" do
      book         = create(:book)
      helper.is_organizer?(book).should be_false
    end

    it "should return false if a user is passed but there's no @book set" do
      user = create(:user)
      helper.is_organizer?(nil, user).should be_false
    end
  end


  describe "is_collaborator?" do
    it "returns false if @book is not set" do
      @current_user = create(:user)
      helper.is_collaborator?.should be_false
      helper.is_collaborator?.should_not be_nil
    end
    
    it "don't returns nil if @book is not set" do
      @current_user = create(:user)
      helper.is_collaborator?.should_not be_nil
    end

    it "returns false if current_user is not set" do
      @book = create(:book)
      helper.is_collaborator?.should be_false
    end

    it "don't returns nil if current_user is not set" do
      @book = create(:book)
      helper.is_collaborator?.should_not be_nil
    end

    it "returns true if the current_user is a collaborator" do
      @book         = create(:book_with_users)
      @current_user = @book.users.first
      helper.is_collaborator?.should be_true
    end

    it "returns false if the current_user isnt a collaborator" do
      @book         = create(:book)
      @current_user = create(:user)
      helper.is_collaborator?.should be_false
    end

    it "should accept a book and an user as params" do
      book         = create(:book_with_users)
      user         = book.users.first
      expect { helper.is_collaborator?(book, user) }.to_not raise_error
    end

    it "should return false if a book is passed but there's no current_user set" do
      book         = create(:book)
      helper.is_collaborator?(book).should be_false
    end

    it "should return false if a user is passed but there's no @book set" do
      user = create(:user)
      helper.is_collaborator?(nil, user).should be_false
    end
  end
end