class Ckeditor::PicturesController < Ckeditor::ApplicationController

  def index
    @pictures = Ckeditor.picture_model.find_all(ckeditor_pictures_scope(:assetable_id => session['book_id']))
    respond_with(@pictures)
  end

  def create
    @picture = Ckeditor::Picture.new
    respond_with_asset(@picture)

    #["content", "original", "thumb"].each do |prefix|
    #  system "convert public/ckeditor_assets/pictures/#{prefix}_#{@picture.data_file_name} -fx '(r+g+b)/3' -colorspace Gray public/ckeditor_assets/pictures/#{prefix}_#{@picture.data_file_name}"
    #end
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

  # overwrite this method from Ckeditor::ApplicationController
  def respond_with_asset(asset)
    file = params[:CKEditor].blank? ? params[:qqfile] : params[:upload]
    asset.data = Ckeditor::Http.normalize_param(file, request)

    callback = ckeditor_before_create_asset(asset)

    # params[:CKEditor].blank? , the call is from tab1.  else,  the call is from tab3
    if callback && asset.save
      body = params[:CKEditor].blank? ? asset.to_json(:only=>[:id, :type]) : %Q"<script type='text/javascript'>
      window.parent.CKEDITOR.tools.callFunction(#{params[:CKEditorFuncNum]}, '#{Ckeditor::Utils.escape_single_quotes(asset.url_content)}');
      </script>"
      render :text => body
    else
      if body = params[:CKEditor].blank? 
        render :json => { :error => asset.errors.messages[:data].first }
        return
      else
        @image = asset
      end

    end
  end
end