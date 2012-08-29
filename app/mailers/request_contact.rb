class RequestContact < ActionMailer::Base
	default :from => "leads@livrodaclasse.com.br"
	
	def report_lead(form)
		@form = form
		mail(:to => "marcelo.polli@gmail.com", :subject => "[Livro da Classe] Solicitação de contato")
	end

end