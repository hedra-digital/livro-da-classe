require 'spec_helper'

describe CollaboratorsController do
  let(:book)              { create(:book) }
  let(:collaborator)      { create(:collaborator, :books => [book]) }
  let(:valid_session)     { { :current_user => create(:user) } }
  let(:valid_attributes)  { attributes_for(:collaborator) }

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

  describe "GET new" do
    it "assigns a new collaborator as @collaborator" do
      get :new, {:book_id => book.id}, valid_session
      assigns(:collaborator).should be_a_new(User)
    end
  end

  describe "GET edit" do
    it "assigns the requested collaborator as @collaborator" do
      collaborator = book.collaborators.create! valid_attributes
      get :edit, {:book_id => book.id, :id => collaborator.to_param}, valid_session
      assigns(:collaborator).should eq(collaborator)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Collaborator" do
        expect {
          post :create, {:book_id => book.id, :collaborator => valid_attributes}, valid_session
        }.to change(User, :count).by(1)
      end

      it "assigns a newly created collaborator as @collaborator" do
        post :create, {:book_id => book.id, :collaborator => valid_attributes}, valid_session
        assigns(:collaborator).should be_a(User)
        assigns(:collaborator).should be_persisted
      end

      it "redirects to the created collaborator" do
        post :create, {:book_id => book.id, :collaborator => valid_attributes}, valid_session
        response.should redirect_to(User.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved collaborator as @collaborator" do
        # Trigger the behavior that occurs when invalid params are submitted
        User.any_instance.stub(:save).and_return(false)
        post :create, {:book_id => book.id, :collaborator => {  }}, valid_session
        assigns(:collaborator).should be_a_new(User)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        User.any_instance.stub(:save).and_return(false)
        post :create, {:book_id => book.id, :collaborator => {  }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested collaborator" do
        collaborator = book.collaborators.create! valid_attributes
        # Assuming there are no other collaborators in the database, this
        # specifies that the Collaborator created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        User.any_instance.should_receive(:update_attributes).with({ "these" => "params" })
        put :update, {:book_id => book.id, :id => collaborator.to_param, :collaborator => { "these" => "params" }}, valid_session
      end

      it "assigns the requested collaborator as @collaborator" do
        collaborator = book.collaborators.create! valid_attributes
        put :update, {:book_id => book.id, :id => collaborator.to_param, :collaborator => valid_attributes}, valid_session
        assigns(:collaborator).should eq(collaborator)
      end

      it "redirects to the collaborator" do
        collaborator = book.collaborators.create! valid_attributes
        put :update, {:book_id => book.id, :id => collaborator.to_param, :collaborator => valid_attributes}, valid_session
        response.should redirect_to(collaborator)
      end
    end

    describe "with invalid params" do
      it "assigns the collaborator as @collaborator" do
        collaborator = book.collaborators.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        User.any_instance.stub(:save).and_return(false)
        put :update, {:book_id => book.id, :id => collaborator.to_param, :collaborator => {  }}, valid_session
        assigns(:collaborator).should eq(collaborator)
      end

      it "re-renders the 'edit' template" do
        collaborator = book.collaborators.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        User.any_instance.stub(:save).and_return(false)
        put :update, {:book_id => book.id, :id => collaborator.to_param, :collaborator => {  }}, valid_session
        response.should render_template("edit")
      end
    end
  end
end
