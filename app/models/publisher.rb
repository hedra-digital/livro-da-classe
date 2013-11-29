# encoding: UTF-8

class Publisher < ActiveRecord::Base

  attr_accessible               :name, :url, :logo, :logo_alternative, :official_name, :address, :district, :city, :uf, :telephone, :trello_email, :text_email

  has_attached_file :logo,
                    :styles => {
                      :normal => ["600x600>", :png],
                      :small => ["300x300#", :png]
                    }

  has_attached_file :logo_alternative,
                    :styles => {
                      :normal => ["600x600>", :png],
                      :small => ["300x300#", :png]
                    }                    

  def self.get_default
    if Publisher.all.size == 0
    	p = Publisher.new
    	p.name = "7letras"
    	p.url = "7letras.livrodaclasse.com.br"
    	p.official_name = "Viveiros de Castro Editora Ltda."
    	p.address = "Rua Visconde de Pirajá, 580 Loja 320"
    	p.district = "Ipanema"
    	p.city = "Rio de Janeiro"
    	p.uf = "RJ"
    	p.telephone = "(21) 2540-0076"
      p.trello_email = "chagas+eoyipyvrcukn3uslydul@boards.trello.com"
      p.text_email = ""
    	p.save
    end
  	Publisher.first
  end

  def self.get_current request_host
    publisher = Publisher.where("url LIKE ?", "%#{request_host}%").first
    if publisher.nil?
      Publisher.get_default
    else
      publisher
    end
  end

end