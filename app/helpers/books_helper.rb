module BooksHelper
  def book_status_label(book)
    tags = ""
    if book.project.present?
      tags << content_tag(:span, "Projeto Hedra", :class => 'label label-warning')
    else
      tags << content_tag(:span, "Projeto individual", :class => 'label label-info')
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
end
