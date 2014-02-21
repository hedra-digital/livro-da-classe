module Admin::UserHelper

  def user_book_remove_label(book, user)
    tags = ""
    tags << link_to('Remover', admin_users_remove_book_path(:id => user.id, :book_id => book.id), :class => 'btn btn-danger btn-mini',
      :confirm => 'Tem certeza que deseja remover essa relação?', :method => :delete)
    tags.html_safe
  end
end