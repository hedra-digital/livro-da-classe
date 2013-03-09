require "spec_helper"

describe TextsController do
  describe "routing" do
    it "routes to #index" do
      get("/books/1/texts").should route_to("texts#index", :book_id => "1")
    end

    it "routes to #new" do
      get("/books/1/texts/new").should route_to("texts#new", :book_id => "1")
    end

    it "routes to #show" do
      get("/books/1/texts/1").should route_to("texts#show", :id => "1", :book_id => "1")
    end

    it "routes to #edit" do
      get("/books/1/texts/1/edit").should route_to("texts#edit", :id => "1", :book_id => "1")
    end

    it "routes to #create" do
      post("/books/1/texts").should route_to("texts#create", :book_id => "1")
    end

    it "routes to #update" do
      put("/books/1/texts/1").should route_to("texts#update", :id => "1", :book_id => "1")
    end

    it "routes to #destroy" do
      delete("/books/1/texts/1").should route_to("texts#destroy", :id => "1", :book_id => "1")
    end
  end
end
