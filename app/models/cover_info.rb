class CoverInfo < ActiveRecord::Base
  belongs_to :book
  attr_accessible :texto_quarta_capa, :autor, :book_id, :organizador, :texto_na_lombada, :titulo_linha1, :titulo_linha2, :titulo_linha3
  
  attr_accessible :capa_imagem
  has_attached_file :capa_imagem, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  
  attr_accessible :capa_detalhe
  has_attached_file :capa_detalhe, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
end
