class ContactForm
	include ActiveModel::Validations
	include ActiveModel::Conversion
	extend ActiveModel::Naming

	attr_accessor :nome_completo, :email, :cargo, :nome_da_escola, :cidade, :estado, :telefone
	
	validates_presence_of :nome_completo, :email, :cargo, :nome_da_escola, :cidade, :estado, :telefone
	validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i

	def initialize(attributes = {})
		attributes.each do |name, value|
			send("#{name}=", value)
		end
	end

	def persisted?
		false
	end

end