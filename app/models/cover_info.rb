class CoverInfo < ActiveRecord::Base
  belongs_to :book
  attr_accessible :texto_quarta_capa, :autor, :book_id, :organizador, :texto_na_lombada, :titulo_linha1, :titulo_linha2, :titulo_linha3, :cor_primaria, :cor_secundaria, 
  					:logo_x1, :logo_x2, :logo_y1, :logo_y2, :logo_w, :logo_h

  #after_update :crop_logo, :if => :cropping_logo?
  #after_update :crop_capa, :if => :cropping_capa?
  #after_update :crop_detalhe, :if => :cropping_detalhe?
  
  attr_accessible :capa_imagem, :capa_imagem_x1, :capa_imagem_x2, :capa_imagem_y1, :capa_imagem_y2, :capa_imagem_w, :capa_imagem_h
  has_attached_file :capa_imagem, :styles => { :normal => ["600x600>", :jpg], :small => ["300x300#", :jpg] }, :default_url => "/images/:style/missing.png"
  
  attr_accessible :capa_detalhe, :capa_detalhe_x1, :capa_detalhe_x2, :capa_detalhe_y1, :capa_detalhe_y2, :capa_detalhe_w, :capa_detalhe_h
  has_attached_file :capa_detalhe, :styles => { :normal => ["600x600>", :jpg], :small => ["300x300#", :jpg] }, :default_url => "/images/:style/missing.png"

  #after_update :crop_capa, :if => :cropping_capa?
  #after_update :crop_detalhe, :if => :cropping_detalhe?

  def cropping_logo?  
    !logo_x1.blank? && !logo_x2.blank? && !logo_y1.blank? && !logo_y2.blank?  
  end

  def cropping_capa?  
    !capa_imagem_x1.blank? and !capa_imagem_y1.blank? and !capa_imagem_w.blank? and !capa_imagem_h.blank?
  end

  def cropping_detalhe?  
    !capa_detalhe_x1.blank? and !capa_detalhe_y1.blank? and !capa_detalhe_w.blank? and !capa_detalhe_h.blank?  
  end

  private  

  #def crop_logo  
    #Book.where(:id => self.book_id).first.capa_imagem.reprocess!  
  #end

  #def crop_capa  
  #  capa_imagem.reprocess!  
  #end  

  #def crop_detalhe  
  #  capa_detalhe.reprocess!  
  #end
end