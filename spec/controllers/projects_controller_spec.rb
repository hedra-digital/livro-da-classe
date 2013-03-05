require 'spec_helper'

describe ProjectsController do
  let(:book)              { create(:book) }
  let(:valid_session)     { { :current_user => create(:user) } }

  before do
    controller.stub(:current_user).and_return(valid_session[:current_user])
  end

  describe "GET new" do
    it "returns http success" do
      get :new, {:book_id => book.id}, valid_session
      response.should be_success
    end
  end

  describe "POST create" do
    pending
  end

end
