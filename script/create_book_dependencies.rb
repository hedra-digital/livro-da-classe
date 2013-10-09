Book.all.each do |book|
  book.build_project quantity: 50 if book.project.nil?
  book.build_cover_info if book.cover_info.nil?
  book.save
end