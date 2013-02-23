require 'spec_helper'

describe TextsController do
  let(:book)              { create(:book) }
  let(:text)              { create(:text, :book_id => book.id) }
  let(:valid_session)     { { :current_user => create(:user) } }
  let(:valid_attributes)  { attributes_for(:text) }

  before do
    controller.stub(:current_user).and_return(valid_session[:current_user])
  end

  describe "GET index" do
    it "assigns all texts as @texts" do
      text = book.texts.create! valid_attributes
      get :index, {:book_id => book.id}, valid_session
      assigns(:texts).should eq([text])
    end
  end

  describe "GET show" do
    it "assigns the requested text as @text" do
      get :show, {:book_id => book.id, :id => text.to_param}, valid_session
      assigns(:text).should eq(text)
    end

    it "assign a new comment as @comment" do
      get :show, {:book_id => book.id, :id => text.to_param}, valid_session
      assigns(:comment).should be_a_new(Comment)
    end
  end

  describe "GET new" do
    it "assigns a new text as @text" do
      get :new, {:book_id => book.id}, valid_session
      assigns(:text).should be_a_new(Text)
    end
  end

  describe "GET edit" do
    it "assigns the requested text as @text" do
      get :edit, {:book_id => book.id, :id => text.to_param}, valid_session
      assigns(:text).should eq(text)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Text" do
        expect {
          post :create, {:book_id => book.id, :text => valid_attributes}, valid_session
        }.to change(Text, :count).by(1)
      end

      it "assigns a newly created text as @text" do
        post :create, {:book_id => book.id, :text => valid_attributes}, valid_session
        assigns(:text).should be_a(Text)
        assigns(:text).should be_persisted
      end

      it "redirects to the edit page for created text" do
        post :create, {:book_id => book.id, :text => valid_attributes}, valid_session
        response.should redirect_to(edit_book_text_path(Text.last.book.uuid, Text.last.uuid))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved text as @text" do
        Text.any_instance.stub(:save).and_return(false)
        post :create, {:book_id => book.id, :text => {  }}, valid_session
        assigns(:text).should be_a_new(Text)
      end

      it "re-renders the 'new' template" do
        Text.any_instance.stub(:save).and_return(false)
        post :create, {:book_id => book.id, :text => {  }}, valid_session
        response.should render_template("new")
      end
    end

    describe "with no params" do
      it "redirects to edit" do
        post :create, {:book_id => book.id}, valid_session
        response.should redirect_to(edit_book_text_path(Text.last.book.uuid, Text.last.uuid))
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested text" do
        Text.any_instance.should_receive(:update_attributes).with({ "these" => "params" })
        put :update, {:book_id => book.id, :id => text.to_param, :text => { "these" => "params" }}, valid_session
      end

      it "assigns the requested text as @text" do
        put :update, {:book_id => book.id, :id => text.to_param, :text => valid_attributes}, valid_session
        assigns(:text).should eq(text)
      end

      it "redirects to the text" do
        put :update, {:book_id => book.id, :id => text.to_param, :text => valid_attributes}, valid_session
        response.should redirect_to(book_text_path(Text.last.book.uuid, Text.last.uuid))
      end
    end

    describe "with invalid params" do
      it "assigns the text as @text" do
        Text.any_instance.stub(:save).and_return(false)
        put :update, {:book_id => book.id, :id => text.to_param, :text => {  }}, valid_session
        assigns(:text).should eq(text)
      end

      it "re-renders the 'edit' template" do
        Text.any_instance.stub(:save).and_return(false)
        put :update, {:book_id => book.id, :id => text.to_param, :text => {  }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested text" do
      valid_attributes[:book_id] = book.id
      text = Text.create! valid_attributes
      expect {
        delete :destroy, {:id => text.to_param, :book_id => book.id}, valid_session
      }.to change(Text, :count).by(-1)
    end

    it "redirects to the texts list" do
      delete :destroy, {:book_id => book.id, :id => text.to_param}, valid_session
      response.should redirect_to(book_path(text.book.uuid))
    end
  end

end
