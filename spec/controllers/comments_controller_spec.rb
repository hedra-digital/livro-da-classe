require 'spec_helper'

describe CommentsController do
  let(:book)              { create(:book) }
  let(:text)              { create(:text, :book_id => book.id) }
  let(:valid_session)     { { :current_user => create(:user) } }
  let(:valid_attributes)  { attributes_for(:comment) }

  describe "POST create" do

    describe "with valid params" do
      it "creates a new Comment" do
        expect {
          post :create, {:book_id => book.id, :text_id => text.id, :comment => valid_attributes}, valid_session
        }.to change(Comment, :count).by(1)
      end

      it "assigns a newly created comment as @comment" do
        post :create, {:book_id => book.id, :text_id => text.id,:comment => valid_attributes}, valid_session
        assigns(:comment).should be_a(Comment)
        assigns(:comment).should be_persisted
      end

      it "redirects to the text page" do
        post :create, {:book_id => book.id, :text_id => text.id, :comment => valid_attributes}, valid_session
        response.should redirect_to(book_text_path(book.uuid, text.uuid))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved comment as @comment" do
        # Trigger the behavior that occurs when invalid params are submitted
        @request.env['HTTP_REFERER'] = 'http://test.com/sessions/new'
        Comment.any_instance.stub(:save).and_return(false)
        post :create, {:comment => {  }, :book_id => book.id, :text_id => text.id, }, valid_session
        assigns(:comment).should be_a_new(Comment)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Comment.any_instance.stub(:save).and_return(false)
        post :create, {:comment => {  }, :book_id => book.id, :text_id => text.id, }, valid_session
        response.status.should be(302)
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested comment" do
      comment = Comment.create! valid_attributes
      expect {
        delete :destroy, {:book_id => book.id, :text_id => text.id, :id => comment.to_param}, valid_session
      }.to change(Comment, :count).by(-1)
    end

    it "redirects to the text page" do
      comment = Comment.create! valid_attributes
      delete :destroy, {:book_id => book.id, :text_id => text.id, :id => comment.to_param}, valid_session
      response.should redirect_to(book_text_path(book.uuid, text.uuid))
    end
  end

end
