class AdminMailer < ActionMailer::Base
  default from: Livrodaclasse::Application.config.action_mailer.default_url_options[:sender_address]
  default to: "fellipe@vizir.com.br"

  def pdf_to_latex_error(book, directory, error_file)
    @title = book.title
    @template = book.template
    @institution = book.institution
    @organizer_name = book.organizer.name
    @impersonate = "http://#{Livrodaclasse::Application.config.action_mailer.default_url_options[:host]}/admin?impersonate_user_id=#{book.organizer.id}"
    @directory = directory
    
    attachments['error.log'] = File.read(error_file)
    
    mail(subject: "[LATEX] #{Livrodaclasse::Application.config.action_mailer.default_url_options[:email_prefix]} - #{@title.upcase}")
  end
end
