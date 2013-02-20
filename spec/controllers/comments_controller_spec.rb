require 'spec_helper'

describe CommentsController do
  let(:book)              { create(:book) }
  let(:text)              { create(:text, :book_id => book.id) }
  let(:valid_session)     { { :current_user => create(:user) } }
  let(:valid_attributes)  { attributes_for(:comment) }

  describe "GET index" do
    it "assigns all comments as @comments" do
      comment = Comment.create! valid_attributes
      get :index, {:book_id => book.id, :text_id => text.id}, valid_session
      assigns(:comments).should eq([comment])
    end
  end

  describe "GET new" do
    it "assigns a new comment as @comment" do
      get :new, {:book_id => book.id, :text_id => text.id}, valid_session
      assigns(:comment).should be_a_new(Comment)
    end
  end

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
        Comment.any_instance.stub(:save).and_return(false)
        post :create, {:comment => {  }}, valid_session
        assigns(:comment).should be_a_new(Comment)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Comment.any_instance.stub(:save).and_return(false)
        post :create, {:comment => {  }}, valid_session
        response.should render_template("new")
      end
    end
  end

  # describe "PUT update" do
  #   describe "with valid params" do
  #     it "updates the requested comment" do
  #       comment = Comment.create! valid_attributes
  #       # Assuming there are no other comments in the database, this
  #       # specifies that the Comment created on the previous line
  #       # receives the :update_attributes message with whatever params are
  #       # submitted in the request.
  #       Comment.any_instance.should_receive(:update_attributes).with({ "these" => "params" })
  #       put :update, {:id => comment.to_param, :comment => { "these" => "params" }}, valid_session
  #     end

  #     it "assigns the requested comment as @comment" do
  #       comment = Comment.create! valid_attributes
  #       put :update, {:id => comment.to_param, :comment => valid_attributes}, valid_session
  #       assigns(:comment).should eq(comment)
  #     end

  #     it "redirects to the comment" do
  #       comment = Comment.create! valid_attributes
  #       put :update, {:id => comment.to_param, :comment => valid_attributes}, valid_session
  #       response.should redirect_to(comment)
  #     end
  #   end

  #   describe "with invalid params" do
  #     it "assigns the comment as @comment" do
  #       comment = Comment.create! valid_attributes
  #       # Trigger the behavior that occurs when invalid params are submitted
  #       Comment.any_instance.stub(:save).and_return(false)
  #       put :update, {:id => comment.to_param, :comment => {  }}, valid_session
  #       assigns(:comment).should eq(comment)
  #     end

  #     it "re-renders the 'edit' template" do
  #       comment = Comment.create! valid_attributes
  #       # Trigger the behavior that occurs when invalid params are submitted
  #       Comment.any_instance.stub(:save).and_return(false)
  #       put :update, {:id => comment.to_param, :comment => {  }}, valid_session
  #       response.should render_template("edit")
  #     end
  #   end
  # end

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
