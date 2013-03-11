require 'spec_helper'

describe CommentsController do
  let(:book)              { create(:book_with_texts) }
  let(:text)              { book.texts.first }
  let(:organizer)         { book.organizer }
  let(:valid_attributes)  { attributes_for(:comment) }

  before do
    sign_in organizer
  end

  # describe "GET index" do
  #   it "assigns comments as @comments" do
  #     comment = Comment.create! valid_attributes
  #     get :index, :book_id => book.id, :text_id => text.id
  #     assigns(:comments).should eq([comment])
  #   end
  # end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Comment" do
        expect {
          post :create, :book_id => book.id, :text_id => text.id, :comment => valid_attributes
        }.to change(Comment, :count).by(1)
      end

      it "assigns a newly created comment as @comment" do
        post :create, :book_id => book.id, :text_id => text.id, :comment => valid_attributes
        assigns(:comment).should be_a(Comment)
        assigns(:comment).should be_persisted
      end

      it "redirects to the text page" do
        post :create, :book_id => book.id, :text_id => text.id, :comment => valid_attributes
        response.should redirect_to(book_text_path(book.uuid, text.uuid))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved comment as @comment" do
        # Trigger the behavior that occurs when invalid params are submitted
        @request.env['HTTP_REFERER'] = 'http://test.com/sessions/new'
        Comment.any_instance.stub(:save).and_return(false)
        post :create, :comment => {  }, :book_id => book.id, :text_id => text.id
        assigns(:comment).should be_a_new(Comment)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Comment.any_instance.stub(:save).and_return(false)
        post :create, :comment => {  }, :book_id => book.id, :text_id => text.id
        response.status.should be(302)
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested comment" do
      comment = Comment.create! valid_attributes
      expect {
        delete :destroy, :book_id => book.id, :text_id => text.id, :id => comment.to_param
      }.to change(Comment, :count).by(-1)
    end

    it "redirects to the text page" do
      comment = Comment.create! valid_attributes
      delete :destroy, :book_id => book.id, :text_id => text.id, :id => comment.to_param
      response.should redirect_to(book_text_path(book.uuid, text.uuid))
    end
  end
end
