require 'spec_helper'

describe ProjectsController do
  let(:book)              { create(:book) }
  let(:valid_session)     { { :current_user => create(:user) } }
  let(:project)           { build_stubbed(:project) }
  let(:valid_attributes)  { attributes_for(:project) }

  before do
    controller.stub(:current_user).and_return(valid_session[:current_user])
  end

  describe "GET new" do
    it "assigns a new project as @project" do
      get :new, {:book_id => book.id}, valid_session
      assigns(:project).should be_a_new(Project)
    end
  end

  describe "POST create" do
    it "assigns a newly created project as @project" do
      post :create, {:book_id => book.id, :project => valid_attributes}, valid_session
      assigns(:project).should be_a(Project)
      assigns(:project).should be_persisted
    end

    it "redirects to the book page" do
      post :create, {:book_id => book.id, :project => valid_attributes}, valid_session
      response.should redirect_to(book_path(book.uuid))
    end
  end
end
