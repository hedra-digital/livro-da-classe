module BooksHelper

  def words_per_text(text)
    text.scan(/\w+/).size 
  end

  def text_status_for(text)
    response = text.finished_at.nil? ? "N&atilde;o terminado" : "Finalizado"
    raw(response)
  end

  def person_name_for(text)
    response = text.person.first.name  rescue  "Nome n&atilde;o informado"
    raw(response)
  end
end