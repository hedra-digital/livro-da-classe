require 'spec_helper'

describe BooksController do
  let(:books) { FactoryGirl.create_list(:book, 3) }
  let(:organizer) { create(:user, :books => books) }
  let(:book) { books.first }

  before do
    controller.stub(:current_user).and_return(valid_session[:current_user])
  end

  # This should return the minimal set of attributes required to create a valid
  # Book. As you add validations to Book, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {
      :title => "Foo",
      :organizer => organizer
    }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # BooksController. Be sure to keep this updated too.
  def valid_session
    {
      :current_user => organizer
    }
  end

  describe "GET index" do
    it "assigns all books as @books" do
      get :index, {}, valid_session
      assigns(:books).should eq(books)
    end
  end

  describe "GET show" do
    it "assigns the requested book as @book" do
      get :show, {:id => book.to_param}, valid_session
      assigns(:book).should eq(book)
    end
  end

  describe "GET new" do
    it "assigns a new book as @book" do
      get :new, {:organizer_id => valid_session[:current_user]}, valid_session
      assigns(:book).should be_a_new(Book)
    end
  end

  describe "GET edit" do
    it "assigns the requested book as @book" do
      get :edit, {:id => book.to_param}, valid_session
      assigns(:book).should eq(book)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Book" do
        expect {
          post :create, {:book => valid_attributes}, valid_session
        }.to change(Book, :count).by(1)
      end

      it "assigns a newly created book as @book" do
        post :create, {:book => valid_attributes}, valid_session
        assigns(:book).should be_a(Book)
        assigns(:book).should be_persisted
      end

      it "redirects to the created book" do
        post :create, {:book => valid_attributes}, valid_session
        response.should redirect_to(Book.last)
      end
    end

    describe "with invalid params" do
      before do
        controller.stub(:current_user).and_return(valid_session[:current_user])
      end
      it "assigns a newly created but unsaved book as @book" do
        # Trigger the behavior that occurs when invalid params are submitted
        Book.any_instance.stub(:save).and_return(false)
        post :create, {:book => {  }}, valid_session
        assigns(:book).should be_a_new(Book)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Book.any_instance.stub(:save).and_return(false)
        post :create, {:book => {  }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested book" do
        book = Book.create! valid_attributes
        # Assuming there are no other books in the database, this
        # specifies that the Book created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Book.any_instance.should_receive(:update_attributes).with({ "these" => "params" })
        put :update, {:id => book.to_param, :book => { "these" => "params" }}, valid_session
      end

      it "assigns the requested book as @book" do
        book = Book.create! valid_attributes
        put :update, {:id => book.to_param, :book => valid_attributes}, valid_session
        assigns(:book).should eq(book)
      end

      it "redirects to the book" do
        book = Book.create! valid_attributes
        put :update, {:id => book.to_param, :book => valid_attributes}, valid_session
        response.should redirect_to(book)
      end
    end

    describe "with invalid params" do
      it "assigns the book as @book" do
        book = Book.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Book.any_instance.stub(:save).and_return(false)
        put :update, {:id => book.to_param, :book => {  }}, valid_session
        assigns(:book).should eq(book)
      end

      it "re-renders the 'edit' template" do
        book = Book.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Book.any_instance.stub(:save).and_return(false)
        put :update, {:id => book.to_param, :book => {  }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested book" do
      book = Book.create! valid_attributes
      expect {
        delete :destroy, {:id => book.to_param}, valid_session
      }.to change(Book, :count).by(-1)
    end

    it "redirects to the books list" do
      book = Book.create! valid_attributes
      delete :destroy, {:id => book.to_param}, valid_session
      response.should redirect_to(books_url(:host => "test.host"))
    end
  end

end
