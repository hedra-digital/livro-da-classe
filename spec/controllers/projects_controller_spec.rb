require 'spec_helper'

describe ProjectsController do
  let(:valid_session)     { { :current_user => create(:user) } }

  before do
    controller.stub(:current_user).and_return(valid_session[:current_user])
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'create'" do
    it "returns http success" do
      get 'create'
      response.should be_success
    end
  end

end
