class AddImagesToCoverInfo < ActiveRecord::Migration
  def self.up
    add_attachment :cover_infos, :capa_imagem
    add_attachment :cover_infos, :capa_detalhe
  end

  def self.down
    remove_attachment :cover_infos, :capa_imagem
    remove_attachment :cover_infos, :capa_detalhe
  end
end
