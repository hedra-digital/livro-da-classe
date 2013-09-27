class ScrapsController < ApplicationController
  def show
    @scrap = Scrap.find params[:id]
    @book = Book.find(@scrap.book_id)
  end

  def create
    @scrap = Scrap.create(content: params[:content])
    Book.find_by_uuid(params[:book]).scraps << @scrap
    render layout: false
  end
end
