module BooksHelper
  def metadata_info_for(field) 
    field.blank? ? raw("<em>n&atilde;o definido</em>")  : field
  end
end
