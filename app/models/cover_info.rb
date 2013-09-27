class CoverInfo < ActiveRecord::Base
  belongs_to :book
  attr_accessible :autor, :book_id, :organizador, :texto_na_lombada, :titulo_linha1, :titulo_linha2, :titulo_linha3
end
