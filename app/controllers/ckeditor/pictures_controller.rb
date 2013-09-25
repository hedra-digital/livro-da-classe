class Ckeditor::PicturesController < Ckeditor::ApplicationController

  def index
    @pictures = Ckeditor.picture_model.find_all(ckeditor_pictures_scope(:assetable_id => session['book_id']))
    respond_with(@pictures)
  end

  def create
    @picture = Ckeditor::Picture.new
    respond_with_asset(@picture)
    ["content", "original", "thumb"].each do |prefix|
      system "convert public/ckeditor_assets/pictures/#{prefix}_#{@picture.data_file_name} -fx '(r+g+b)/3' -colorspace Gray public/ckeditor_assets/pictures/#{prefix}_#{@picture.data_file_name}"
    end
  end

  def destroy
    @picture.destroy
    respond_with(@picture, :location => pictures_path)
  end

  protected

    def find_asset
      @picture = Ckeditor.picture_model.get!(params[:id])
    end

    def authorize_resource
      model = (@picture || Ckeditor::Picture)
      @authorization_adapter.try(:authorize, params[:action], model)
    end


end