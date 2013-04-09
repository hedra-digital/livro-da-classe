require 'spec_helper'

describe TextsController do
  let!(:user)             { create(:user) }
  let!(:book)             { create(:book_with_texts) }
  let(:text)              { book.texts.first }
  let(:valid_attributes)  { attributes_for(:text) }

  before do
    sign_in user
  end

  describe "GET index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index, :book_id => book.id
      expect(response).to be_success
      expect(response.code).to eq("200")
    end

    it "assigns all texts as @texts" do
      get :index, :book_id => book.id
      assigns(:texts).should eq(book.texts.order(:position))
    end
  end

  describe "GET show" do
    it "assigns the requested text as @text" do
      get :show, :book_id => book.id, :id => text.to_param
      assigns(:text).should eq(text)
    end

    it "assign a new comment as @comment" do
      get :show, :book_id => book.id, :id => text.to_param
      assigns(:comment).should be_a_new(Comment)
    end
  end

  describe "GET new" do
    it "assigns a new text as @text" do
      get :new, :book_id => book.id
      assigns(:text).should be_a_new(Text)
    end
  end

  describe "GET edit" do
    it "assigns the requested text as @text" do
      get :edit, :book_id => book.id, :id => text.to_param
      assigns(:text).should eq(text)
    end
  end

  describe "POST create" do
    context "with valid params" do
      it "creates a new Text" do
        expect{ post :create, :book_id => book.id, :text => valid_attributes }.to change{ Text.all.size }.by(1)
      end

      it "assigns a newly created text as @text" do
        post :create, :book_id => book.id, :text => valid_attributes
        assigns(:text).should be_a(Text)
        assigns(:text).should be_persisted
      end

      it "redirects to the edit page for created text" do
        post :create, :book_id => book.id, :text => valid_attributes
        response.should redirect_to(edit_book_text_path(Text.last.book.uuid, Text.last.uuid))
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved text as @text" do
        Text.any_instance.stub(:save).and_return(false)
        post :create, :book_id => book.id, :text => {  }
        assigns(:text).should be_a_new(Text)
      end

      it "re-renders the 'new' template" do
        Text.any_instance.stub(:save).and_return(false)
        post :create, :book_id => book.id, :text => {  }
        response.should render_template("new")
      end
    end

    context "with no params" do
      it "redirects to edit" do
        post :create, :book_id => book.id
        response.should redirect_to(edit_book_text_path(Text.last.book.uuid, Text.last.uuid))
      end
    end
  end

  describe "PUT update" do
    context "with valid params" do
      it "updates the requested text" do
        Text.any_instance.should_receive(:update_attributes).with({ "these" => "params" })
        put :update, :book_id => book.id, :id => text.to_param, :text => { "these" => "params" }
      end

      it "assigns the requested text as @text" do
        put :update, :book_id => book.id, :id => text.to_param, :text => valid_attributes
        assigns(:text).should eq(text)
      end

      it "redirects to the text" do
        put :update, :book_id => book.id, :id => text.to_param, :text => valid_attributes
        response.should redirect_to(book_text_path(Text.last.book.uuid, Text.last.uuid))
      end
    end

    context "with invalid params" do
      it "assigns the text as @text" do
        Text.any_instance.stub(:save).and_return(false)
        put :update, :book_id => book.id, :id => text.to_param, :text => {  }
        assigns(:text).should eq(text)
      end

      it "re-renders the 'edit' template" do
        Text.any_instance.stub(:save).and_return(false)
        put :update, :book_id => book.id, :id => text.to_param, :text => {  }
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested text" do
      valid_attributes[:book_id] = book.id
      text = Text.create! valid_attributes
      expect {
        delete :destroy, :id => text.to_param, :book_id => book.id
      }.to change(Text, :count).by(-1)
    end

    it "redirects to the texts list" do
      delete :destroy, :book_id => book.id, :id => text.to_param
      response.should redirect_to(book_path(text.book.uuid))
    end
  end

end
