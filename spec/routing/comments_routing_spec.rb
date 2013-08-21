require "spec_helper"

describe CommentsController do
  describe "routing" do

    it "routes to #index" do
      get("/books/1/texts/1/comments").should route_to("comments#index", :book_id => "1", :text_id => "1")
    end

    it "routes to #new" do
      get("/books/1/texts/1/comments/new").should route_to("comments#new", :book_id => "1", :text_id => "1")
    end

    it "routes to #show" do
      get("/books/1/texts/1/comments/1").should route_to("comments#show", :id => "1", :book_id => "1", :text_id => "1")
    end

    it "routes to #create" do
      post("/books/1/texts/1/comments").should route_to("comments#create", :text_id => "1", :book_id => "1")
    end

    # it "routes to #update" do
    #   put("/books/1/texts/1/comments/1").should route_to("comments#update", :id => "1", :book_id => "1", :text_id => "1")
    # end

    it "routes to #destroy" do
      delete("/books/1/texts/1/comments/1").should route_to("comments#destroy", :id => "1", :book_id => "1", :text_id => "1")
    end

  end
end
