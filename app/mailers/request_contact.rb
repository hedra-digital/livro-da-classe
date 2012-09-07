# coding: utf-8
class RequestContact < ActionMailer::Base
	default :from => 'marcelo@livrodaclasse.com.br'

	headers = {'Return-Path' => 'marcelo@livrodaclasse.com.br'}
	
	def report_lead(lead_info)
		@lead_info = lead_info
		mail(
			:to => ["marcelo.polli@gmail.com", "fabio@hedra.com.br"],
			:subject => "[Livro da Classe] Solicitação de contato",
			:return_path => "marcelo@livrodaclasse.com.br",
			:date => Time.now
		)
	end

end