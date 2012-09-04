class ContactController < ApplicationController
	layout 'home'

	def new
		@contact_form = ContactForm.new
	end

	def send_lead
		@contact_form = ContactForm.new(params[:request_contact_form])
		if @contact_form.valid?
			RequestContact.report_lead(@contact_form).deliver
			redirect_to root_path, :notice => "Obrigado pelo seu interesse no Livro da Classe. Entraremos em contato dentro de 24 horas."
		else
			render :new
		end
	end

end