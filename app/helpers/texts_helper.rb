module TextsHelper
  def enable_or_disable_link(text)
    return '' if !is_organizer?
    label = !text.is_enabled? ? 'Aprovado' : 'Aprovar'
    klass = !text.is_enabled? ? 'btn btn-success btn-mini text-btn-enabled' : 'btn btn-warning btn-mini text-btn-disabled'
    link_to(label, enable_or_disable_path(:uuid => text.uuid), :class => klass)
  end

  def text_title(book, text)
  	return link_to(text.title, book_text_path(book.uuid, text.uuid)) if is_organizer?
    !text.is_enabled? ? text.title : link_to(text.title, book_text_path(book.uuid, text.uuid))
  end  
end
