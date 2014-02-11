module Admin::ApplicationHelper

  def publisher_admin_logo
    Publisher.get_current(request.host).logo_alternative.url(:normal)
  end

  def title_text(book)
    book.book_data.autor.blank? ? book.title : "#{book.book_data.autor} — #{book.title}"
  end

end
