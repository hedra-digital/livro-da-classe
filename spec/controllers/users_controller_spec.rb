require 'spec_helper'

describe UsersController do
  let(:user)              { create(:user) }
  let(:valid_session)     { { :current_user => user } }
  let(:valid_attributes)  { attributes_for(:user) }

  before do
    controller.stub(:current_user).and_return(valid_session[:current_user])
  end

  describe "GET show" do
    it "assigns the current user as @user" do
      get :show, {:id => user.to_param}, valid_session
      assigns(:user).should eq(user)
    end
  end

  describe "GET new" do
    it "assigns a new user as @user" do
      get :new
      assigns(:user).should be_a_new(User)
    end
  end

  describe "POST create" do
    context "with valid params" do
      it "creates a new User" do
        expect {
          post :create, {:user => valid_attributes}
        }.to change(User, :count).by(1)
      end

      it "assigns a newly created user as @user" do
        post :create, {:user => valid_attributes}
        assigns(:user).should be_a(User)
        assigns(:user).should be_persisted
      end

      it "redirects to the app home" do
        post :create, {:user => valid_attributes}
        response.should redirect_to(app_home_path)
      end
    end

    context "with invalid params" do
      it "assigns a newly crated but unsaved user as @user" do
        User.any_instance.stub(:save).and_return(false)
        post :create, {:user => { }}
        assigns(:user).should be_a_new(User)
      end

      it "re-renders the 'new' template" do
        User.any_instance.stub(:save).and_return(false)
        post :create, {:user => { }}
        response.should render_template("new")
      end
    end
  end

  describe "GET edit" do
    it "assigns the current user as @user" do
      get :show, {:id => user.to_param}, valid_session
      assigns(:user).should eq(user)
    end
  end

  describe "PUT update" do
    context "with valid params" do
      it "updates the current user" do
        User.any_instance.should_receive(:update_attributes).with(valid_attributes.with_indifferent_access)
        put :update, {:id => user.to_param, :user => valid_attributes}, valid_session
      end

      it "assigns the updated user as @user" do
        put :update, {:id => user.to_param, :user => valid_attributes}, valid_session
        assigns(:user).should eq(user)
      end

      it "redirects to the current user's profile" do
        put :update, {:id => user.to_param, :user => valid_attributes}, valid_session
        response.should redirect_to(user)
      end
    end

    context "with invalid params" do
      it "assigns the book as @book" do
        User.any_instance.stub(:save).and_return(false)
        put :update, {:id => user.to_param, :user => {  }}, valid_session
        assigns(:user).should eq(user)
      end

      it "re-renders the 'edit' template" do
        User.any_instance.stub(:save).and_return(false)
        put :update, {:id => user.to_param, :user => {  }}, valid_session
        response.should render_template("edit")
      end
    end
  end
end
