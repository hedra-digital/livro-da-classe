require 'spec_helper'

describe UsersController do
  let(:user)              { create(:user) }
  let(:valid_attributes)  { attributes_for(:user) }

  before do
    sign_in user
  end

  describe "GET show" do
    it "assigns the current user as @user" do
      get :show, :id => user.to_param
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
      get :show, :id => user.to_param
      assigns(:user).should eq(user)
    end
  end

  describe "PUT update" do
    context "with valid params" do
      it "updates the current user" do
        User.any_instance.should_receive(:update_attributes).with(valid_attributes.with_indifferent_access)
        put :update, :id => user.to_param, :user => valid_attributes
      end

      it "assigns the updated user as @user" do
        put :update, :id => user.to_param, :user => valid_attributes
        assigns(:user).should eq(user)
      end

      it "redirects to the current user's profile" do
        put :update, :id => user.to_param, :user => valid_attributes
        response.should redirect_to(user)
      end
    end

    context "with invalid params" do
      it "assigns the book as @book" do
        User.any_instance.stub(:save).and_return(false)
        put :update, :id => user.to_param, :user => {  }
        assigns(:user).should eq(user)
      end

      it "re-renders the 'edit' template" do
        User.any_instance.stub(:save).and_return(false)
        put :update, :id => user.to_param, :user => {  }
        response.should render_template("edit")
      end
    end

    context "when referred by UserController#email" do
      it "should update the current_user email address" do
        User.any_instance.should_receive(:update_attributes).with(valid_attributes.with_indifferent_access)
        put :update, :id => user.to_param, :user => valid_attributes
      end

      it "should render the email view if there's any errors" do
        User.any_instance.stub(:save).and_return(false)
        put :update, :id => user.to_param, :user => {  }, :email_gate => true
        response.should render_template("email")
      end
    end

  end

  describe "GET email" do
     it "assigns the current user as @user" do
      get :show, :id => user.to_param
      assigns(:user).should eq(user)
    end
  end
end
