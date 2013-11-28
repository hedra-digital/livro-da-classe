# encoding: UTF-8

class Publisher < ActiveRecord::Base

  attr_accessible               :name, :url, :logo, :official_name, :address, :district, :city, :uf, :telephone

  has_attached_file :logo,
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
    	p.save
    end
  	Publisher.first
  end

end