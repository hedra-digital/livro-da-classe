class ContactForm
	include ActiveModel::Validations
	include ActiveModel::Conversion

	attr_accessor :nome_completo, :email, :cargo, :nome_da_escola, :cidade, :estado, :telefone
	validates_presence_of :nome_completo, :email, :cargo, :nome_da_escola, :cidade, :estado, :telefone
	validates :email, :format => { :with => %r{.+@.+\..+} }, :allow_blank => true

	def initialize(attributes = {})
		attributes.each do |name, value|
			send("#{name}=", value)
		end
	end

	def persisted?
		false
	end

end