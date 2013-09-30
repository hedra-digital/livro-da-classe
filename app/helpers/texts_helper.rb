module TextsHelper
  def enable_or_disable_link(text)
    return '' if !is_organizer?
    label = text.is_disabled? ? 'Aprovar' : 'Aprovado'
    klass = text.is_disabled? ? 'btn btn-warning btn-mini text-btn-disabled' : 'btn btn-success btn-mini text-btn-enabled'
    link_to(label, enable_or_disable_path(:uuid => text.uuid), :class => klass)
  end

  def text_title(book, text)
  	return link_to(text.title, book_text_path(book.uuid, text.uuid)) if is_organizer?
    text.is_disabled? ? text.title : link_to(text.title, book_text_path(book.uuid, text.uuid))
  end  
end
