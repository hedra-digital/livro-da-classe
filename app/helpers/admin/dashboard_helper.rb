module Admin::DashboardHelper

  def admin_book_status(book)
    tags = ""
    if book.project.present? and book.project.engaged?
      tags << remaining_label(book.project)
    end
    tags.html_safe
  end
end
