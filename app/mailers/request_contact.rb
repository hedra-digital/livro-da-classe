# coding: utf-8
class RequestContact < ActionMailer::Base
	default :from => "leads@livrodaclasse.com.br"

	headers = {'Return-Path' => 'marcelo.polli@gmail.com'}
	
	def report_lead(lead_info)
		@lead_info = lead_info
		mail(
			:to => "marcelo.polli@gmail.com",
			:subject => "[Livro da Classe] Solicitação de contato",
			:return_path => "marcelo.polli@gmail.com",
			:date => Time.now
		)
	end

end