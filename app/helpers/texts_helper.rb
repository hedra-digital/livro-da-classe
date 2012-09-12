module TextsHelper

  def url_texto
    url = Googl.shorten(book_text_url(@book.uuid, @text.uuid)).short_url
    icon = content_tag :i, nil, :class => 'icon-globe'
    link = link_to url, url
    content_tag :p, icon + '&nbsp;URL do texto:&nbsp;'.html_safe + link
  end

end