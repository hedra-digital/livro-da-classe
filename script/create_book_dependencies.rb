Book.all.each do |book|
  if book.project.nil?
    book.build_project quantity: 50
  end
  if book.cover_info.nil?
    book.build_cover_info
  end
  book.save
end