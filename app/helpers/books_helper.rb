# encoding: utf-8

module BooksHelper
  def book_status_label(book)
    return unless is_organizer?(book, current_user)
    tags = ""
    if book.project.present? and book.project.engaged?
      tags << remaining_label(book.project)
    elsif book.project.present? and !book.project.engaged?
      tags << link_to('Contratar', edit_book_project_path(book.uuid, book.project.id), :class => 'btn btn-mini')
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

  def book_role_label(book, user)
    tags = ""
    if is_organizer?(book, user)
      tags << content_tag(:span, "Organizador", :class => 'label label-inverse')
    else
      tags << content_tag(:span, "Colaborador", :class => 'label')
    end
    tags.html_safe
  end

  def menu_item(name, path)
    options = {}
    options[:class] = 'active' if current_page?(path)
    content_tag(:li, link_to(name, path), options)
  end

  def book_cover
    if @book.cover.present?
      link_to(image_tag(@book.cover.url(:thumb)), @book.cover.url(:content), :class => 'cover-modal')
    elsif !DefaultCover.first.nil?
      link_to(image_tag(DefaultCover.first.default_cover.url(:thumb)), DefaultCover.first.default_cover.url, :class => 'cover-modal')
    else
      ''
    end
  end
end
