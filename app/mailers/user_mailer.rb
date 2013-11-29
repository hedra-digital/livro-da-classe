# encoding: utf-8

class UserMailer < ActionMailer::Base
  default from: "nao-responda@livrodaclasse.com.br"

  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "Recuperação de senha"
  end

  def book_invitation(inviter, user, book_uuid)
    @user = user
    @inviter = inviter
    @book_uuid = book_uuid
    mail :to => user.email, :subject => "Convite para um projeto no Livro da Classe"
  end

  def status_changed(project, publisher)
    @name = project.book.organizer.name
    @title = project.book.title
    @status = project.status_to_s
    @content = publisher.text_email

    @content = @content.gsub("@name",@name)
    @content = @content.gsub("@status",@status)

    mail :to => project.book.organizer.email, :subject => "[#{publisher.name}] Alteração em status de original"
  end
end
