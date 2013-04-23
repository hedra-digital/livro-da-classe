# encoding: utf-8

module BooksHelper
  def book_status_label(book)
    return unless is_organizer?(book, current_user)
    tags = ""
    if book.project.present?
      tags << remaining_label(book.project)
    else
      tags << link_to('Publicar', new_book_project_path(book), :class => 'btn btn-mini')
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
end
