class TrelloMailer < ActionMailer::Base
  default from: "nao-responda@livrodaclasse.com.br"

  def create_book_card(book, user)
    @title = book.title
    @name = user.name
    @email = user.email
    @telephone = user.telephone
    @abstract = book.abstract
    @impersonate = "http://#{Livrodaclasse::Application.config.action_mailer.default_url_options[:host]}/admin?impersonate_user_id=#{book.organizer.id}"
    @date = book.created_at.strftime("%d/%m/%Y")
    mail :to => "chagas+eoyipyvrcukn3uslydul@boards.trello.com", :subject => "#{@title} (#{@name})"
  end
end
