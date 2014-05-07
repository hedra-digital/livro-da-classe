class TrelloMailer < ActionMailer::Base
  default from: "nao-responda@livrodaclasse.com.br"

  def create_book_card(book, user, publisher)
    @title = book.title
    @name = user.name
    @email = user.email
    @telephone = user.telephone
    @institution = book.institution
    @date = book.created_at.strftime("%d/%m/%Y")
    @release_date = book.project.release_date ? book.project.release_date.strftime("%d/%m/%Y") : nil
    @abstract = book.abstract

    if book.book_data.logo.exists?
      attachments["#{book.book_data.logo_file_name}"] = File.read(book.book_data.logo.path)
    end

    mail :to => "#{publisher.trello_email}", :subject => "#{@title} (#{@name})"
  end
end
