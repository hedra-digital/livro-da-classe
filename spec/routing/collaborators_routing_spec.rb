require "spec_helper"

describe CollaboratorsController do
  describe "routing" do

    it "routes to #index" do
      get("/books/1/collaborators").should route_to("collaborators#index", :book_id => "1")
    end

    it "routes to #new" do
      get("/books/1/collaborators/new").should route_to("collaborators#new", :book_id => "1")
    end

    it "routes to #show" do
      get("/books/1/collaborators/1").should route_to("collaborators#show", :book_id => "1", :id => "1")
    end

    it "routes to #edit" do
      get("/books/1/collaborators/1/edit").should route_to("collaborators#edit", :book_id => "1", :id => "1")
    end

    it "routes to #create" do
      post("/books/1/collaborators").should route_to("collaborators#create", :book_id => "1")
    end

    it "routes to #update" do
      put("/books/1/collaborators/1").should route_to("collaborators#update", :book_id => "1", :id => "1")
    end

    it "routes to #destroy" do
      delete("/books/1/collaborators/1").should route_to("collaborators#destroy", :book_id => "1", :id => "1")
    end

  end
end
