require "spec_helper"

describe CollaborationsController do
  describe "routing" do

    it "routes to #index" do
      get("/books/1/collaborations").should route_to("collaborations#index", :book_id => "1")
    end

    it "routes to #new" do
      get("/books/1/collaborations/new").should route_to("collaborations#new", :book_id => "1")
    end

    it "routes to #show" do
      get("/books/1/collaborations/1").should route_to("collaborations#show", :id => "1", :book_id => "1")
    end

    it "routes to #edit" do
      get("/books/1/collaborations/1/edit").should route_to("collaborations#edit", :id => "1", :book_id => "1")
    end

    it "routes to #create" do
      post("/books/1/collaborations").should route_to("collaborations#create", :book_id => "1")
    end

    it "routes to #update" do
      put("/books/1/collaborations/1").should route_to("collaborations#update", :id => "1", :book_id => "1")
    end

    it "routes to #destroy" do
      delete("/books/1/collaborations/1").should route_to("collaborations#destroy", :id => "1", :book_id => "1")
    end

  end
end
