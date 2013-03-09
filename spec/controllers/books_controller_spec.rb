require 'spec_helper'

describe BooksController do
  let(:organizer)         { create(:organizer) }
  let(:books)             { organizer.organized_books }
  let(:book)              { books.first }
  let(:valid_attributes)  { attributes_for(:book, :organizer_id => organizer.id) }

  before do
    sign_in organizer
  end

  describe "GET index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response.code).to eq("200")
    end

    it "assigns organized books as @books" do
      get :index
      assigns(:books).should eq(books)
    end

    it "redirects to the email page if the current_user meets the requirements" do
      organizer.email           = nil
      organizer.asked_for_email = nil
      get :index
      response.status.should be(302)
    end

    it "shows the index page if current_user has no email but asked_for_email=true" do
      organizer.email           = nil
      get :index
      assigns(:books).should eq(books)
    end
  end

  describe "GET show" do
    it "assigns the requested book as @book" do
      get :show, :id => book.to_param
      assigns(:book).should eq(book)
    end
  end

  describe "GET new" do
    it "assigns a new book as @book" do
      get :new
      assigns(:book).should be_a_new(Book)
    end
  end

  describe "GET edit" do
    it "assigns the requested book as @book" do
      get :edit, :id => book.to_param
      assigns(:book).should eq(book)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Book" do
        expect {
          post :create, :book => valid_attributes
        }.to change(Book, :count).by(1)
      end

      it "assigns a newly created book as @book" do
        post :create, :book => valid_attributes
        assigns(:book).should be_a(Book)
        assigns(:book).should be_persisted
      end

      it "redirects to the created book" do
        post :create, :book => valid_attributes
        response.should redirect_to(book_path(Book.last.uuid))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved book as @book" do
        Book.any_instance.stub(:save).and_return(false)
        post :create, :book => {  }
        assigns(:book).should be_a_new(Book)
      end

      it "re-renders the 'new' template" do
        Book.any_instance.stub(:save).and_return(false)
        post :create, :book => {  }
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested book" do
        Book.any_instance.should_receive(:update_attributes).with({ "these" => "params" })
        put :update, :id => book.to_param, :book => { "these" => "params" }
      end

      it "assigns the requested book as @book" do
        put :update, :id => book.to_param, :book => valid_attributes
        assigns(:book).should eq(book)
      end

      it "redirects to the book" do
        put :update, :id => book.to_param, :book => valid_attributes
        response.should redirect_to(book_path(book.uuid))
      end
    end

    describe "with invalid params" do
      it "assigns the book as @book" do
        Book.any_instance.stub(:save).and_return(false)
        put :update, :id => book.to_param, :book => {  }
        assigns(:book).should eq(book)
      end

      it "re-renders the 'edit' template" do
        Book.any_instance.stub(:save).and_return(false)
        put :update, :id => book.to_param, :book => {  }
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested book" do
      expect {
        delete :destroy, :id => book.to_param
      }.to change(Book, :count).by(-1)
    end

    it "redirects to the books list" do
      delete :destroy, :id => book.to_param
      response.should redirect_to(books_url(:host => "test.host"))
    end
  end
end
