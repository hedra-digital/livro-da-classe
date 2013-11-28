class TrelloMailer < ActionMailer::Base
  default from: "nao-responda@livrodaclasse.com.br"

  def create_book_card(project, book, user)
    @title = book.title
    @name = user.name
    @email = user.email
    @telephone = user.telephone
    @institution = book.institution
    @date = Date.today.strftime("%d/%m/%Y")
    @release_date = project.release_date.strftime("%d/%m/%Y")

    if project.school_logo.exists?
      attachments["#{project.school_logo_file_name}"] = File.read(project.school_logo.path)
    end

    mail :to => "chagas+eoyipyvrcukn3uslydul@boards.trello.com", :subject => "#{@title} (#{@name})"
  end
end
