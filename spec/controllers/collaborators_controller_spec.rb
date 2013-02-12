require 'spec_helper'

describe CollaboratorsController do
  let(:book)              { create(:book) }
  let(:collaborator)      { create(:collaborator, :collaborated_books => [book]) }
  let(:valid_session)     { { :current_user => create(:user) } }
  let(:valid_attributes)  { attributes_for(:text) }

  before do
    controller.stub(:current_user).and_return(valid_session[:current_user])
  end

  describe "GET index" do
    it "assigns all collaborators as @collaborators" do
      collaborator = book.collaborators.create! valid_attributes
      get :index, {:book_id => book.id}, valid_session
      assigns(:collaborators).should eq([collaborator])
    end
  end

  describe "GET show" do
    it "assigns the requested collaborator as @collaborator" do
      get :show, {:id => collaborator.to_param, :book_id => book.id}, valid_session
      assigns(:collaborator).should eq(collaborator)
    end
  end

  describe "GET new" do
    it "assigns a new collaborator as @collaborator" do
      get :new, {}, valid_session
      assigns(:collaborator).should be_a_new(Collaborator)
    end
  end

  describe "GET edit" do
    it "assigns the requested collaborator as @collaborator" do
      collaborator = Collaborator.create! valid_attributes
      get :edit, {:id => collaborator.to_param}, valid_session
      assigns(:collaborator).should eq(collaborator)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Collaborator" do
        expect {
          post :create, {:collaborator => valid_attributes}, valid_session
        }.to change(Collaborator, :count).by(1)
      end

      it "assigns a newly created collaborator as @collaborator" do
        post :create, {:collaborator => valid_attributes}, valid_session
        assigns(:collaborator).should be_a(Collaborator)
        assigns(:collaborator).should be_persisted
      end

      it "redirects to the created collaborator" do
        post :create, {:collaborator => valid_attributes}, valid_session
        response.should redirect_to(Collaborator.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved collaborator as @collaborator" do
        # Trigger the behavior that occurs when invalid params are submitted
        Collaborator.any_instance.stub(:save).and_return(false)
        post :create, {:collaborator => {  }}, valid_session
        assigns(:collaborator).should be_a_new(Collaborator)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Collaborator.any_instance.stub(:save).and_return(false)
        post :create, {:collaborator => {  }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested collaborator" do
        collaborator = Collaborator.create! valid_attributes
        # Assuming there are no other collaborators in the database, this
        # specifies that the Collaborator created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Collaborator.any_instance.should_receive(:update_attributes).with({ "these" => "params" })
        put :update, {:id => collaborator.to_param, :collaborator => { "these" => "params" }}, valid_session
      end

      it "assigns the requested collaborator as @collaborator" do
        collaborator = Collaborator.create! valid_attributes
        put :update, {:id => collaborator.to_param, :collaborator => valid_attributes}, valid_session
        assigns(:collaborator).should eq(collaborator)
      end

      it "redirects to the collaborator" do
        collaborator = Collaborator.create! valid_attributes
        put :update, {:id => collaborator.to_param, :collaborator => valid_attributes}, valid_session
        response.should redirect_to(collaborator)
      end
    end

    describe "with invalid params" do
      it "assigns the collaborator as @collaborator" do
        collaborator = Collaborator.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Collaborator.any_instance.stub(:save).and_return(false)
        put :update, {:id => collaborator.to_param, :collaborator => {  }}, valid_session
        assigns(:collaborator).should eq(collaborator)
      end

      it "re-renders the 'edit' template" do
        collaborator = Collaborator.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Collaborator.any_instance.stub(:save).and_return(false)
        put :update, {:id => collaborator.to_param, :collaborator => {  }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested collaborator" do
      collaborator = Collaborator.create! valid_attributes
      expect {
        delete :destroy, {:id => collaborator.to_param}, valid_session
      }.to change(Collaborator, :count).by(-1)
    end

    it "redirects to the collaborators list" do
      collaborator = Collaborator.create! valid_attributes
      delete :destroy, {:id => collaborator.to_param}, valid_session
      response.should redirect_to(collaborators_url)
    end
  end

end
