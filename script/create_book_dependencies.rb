Book.all.each do |book|
  if book.project.nil?
    book.build_project quantity: 50
  end
  if book.cover_info.nil?
    c = CoverInfo.new
    c.book_id = book.id
    c.texto_quarta_capa = ""
    c.autor = ""
    c.save
  end
  book.save
end