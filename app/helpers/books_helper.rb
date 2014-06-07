# encoding: utf-8

module BooksHelper
  def book_status_label(book)
    return unless is_organizer?(book, current_user)
    tags = ""
    if book.project.present? and book.project.engaged?
      tags << remaining_label(book.project)
    end
    tags.html_safe
  end

  def book_remove_label(book, user)
    return unless is_organizer?(book, user)
    tags = ""
    if book.project.present? and !book.project.engaged?
      tags << link_to('Remover', book_path(book), :class => 'btn btn-danger btn-mini',
       :confirm => 'Tem certeza que deseja apagar este livro?', :method => :delete)
    end
    tags.html_safe
  end

  def book_admin_status_label(book)
    return unless is_organizer?(book, current_user)
    book.project.engaged? ? book.project.status_to_s : link_to('Contratar', edit_book_project_path(book.uuid, book.project.id), :class => 'btn btn-mini').html_safe
  end

  def book_role_label(book, user)
    tags = ""
    if is_organizer?(book, user)
      tags << content_tag(:span, "Organizador", :class => 'label label-inverse')
    else
      tags << content_tag(:span, "Colaborador", :class => 'label')
    end
    tags.html_safe
  end

  def menu_item(name, path, external=nil, type="", blank = false)
    options = {}
    options[:class] = 'active' if current_page?(path)
    
    link_options = {}
    link_options[:target] = "_blank" if blank
    external.nil? ? content_tag(:li, link_to(name, path, link_options), options) : content_tag(:li, link_to(name, path, :id => type), options)
  end

  def book_cover
    if @book.book_data.capainteira.exists?
      link_to(image_tag(@book.book_data.capainteira.url(:thumb)), @book.book_data.capainteira.url(:content), :class => 'cover-modal')
    elsif @book.cover.exists?
      link_to(image_tag(@book.cover.url(:thumb)), @book.cover.url(:content), :class => 'cover-modal')
    elsif !DefaultCover.first.nil?
      link_to(image_tag(DefaultCover.first.default_cover.url(:thumb)), DefaultCover.first.default_cover.url, :class => 'cover-modal')
    else
      ''
    end
  end

  def progress_notification
      image_tag('/assets/ajax-loader.gif', :class => 'progress-modal', :style => 'display: none;')
  end  

  def book_pages(book)
    book.pages_count > 0 ? "#{book.pages_count} páginas" : ""
  end

  def has_ebook?(book)
    book.has_ebook?
  end
end
