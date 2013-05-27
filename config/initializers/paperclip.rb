Paperclip.interpolates :book_id do |attachment, style|
  attachment.instance.book.id.to_s
end
