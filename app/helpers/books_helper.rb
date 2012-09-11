module BooksHelper

  def url_alunos
    url = Googl.shorten(welcome_url(@book.uuid)).short_url
    icon = content_tag :i, nil, :class => 'icon-globe'
    link = link_to url, url
    content_tag :p, icon + '&nbsp;URL para alunos:&nbsp;'.html_safe + link , :style => "float: right;"
  end

  def words_per_text(text)
    text.scan(/\w+/).size rescue 0
  end

  def text_status_for(text)
    response = text.finished_at.nil? ? "N&atilde;o terminado" : "Finalizado"
    raw(response)
  end

  def person_name_for(text)
    response = text.person.first.name  rescue  "Nome do aluno n&atilde;o informado"
    raw(response)
  end
end