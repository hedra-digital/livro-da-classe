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

  # maybe move to db:seeds later
  def self.get_default
    if Publisher.all.size == 0
    	p = Publisher.new
    	p.name = "Editora Hedra"
    	p.url = "livrodaclasse.com.br"
    	p.official_name = "Hedra Educação Ltda."
    	p.address = "Rua Fradique Coutinho 1139 Subsolo"
    	p.district = "Vila Madalena"
    	p.city = "São Paulo"
    	p.uf = "SP"
    	p.telephone = "(11) 3097-8304"
      p.trello_email = "andylin17+l8iz9ezjmd9mofoleacg@boards.trello.com"
      p.text_email = "Caro @name,\n\nSeu livro cadastrado em nosso sistema de aprovação teve seu status alterado para: @status\n\n        Para entrar em contato com nossos editores, utilize o mural presente no site http://livrodaclasse.com.br\n\nEditora Hedra"
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

  def self.get_current_app
    "#{CONFIG[Rails.env.to_sym]["app_name"]}"
  end

end