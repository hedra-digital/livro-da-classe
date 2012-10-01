class PagesController < ApplicationController
	layout 'home'

	def home
	end

	def new
		@contact_form = ContactForm.new
	end

	def send_lead
		@contact_form = ContactForm.new(params[:contact_form])
		if @contact_form.valid?
			RequestContact.report_lead(@contact_form).deliver
			redirect_to solicitar_contato_sucesso_path
		else
			render :new
		end
	end

  def success
  end

end