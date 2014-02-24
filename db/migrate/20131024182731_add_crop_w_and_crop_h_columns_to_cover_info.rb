class AddCropWAndCropHColumnsToCoverInfo < ActiveRecord::Migration
  def change
  	add_column :cover_infos, :logo_w, :integer
  	add_column :cover_infos, :logo_h, :integer

  	add_column :cover_infos, :capa_imagem_w, :integer
  	add_column :cover_infos, :capa_imagem_h, :integer

  	add_column :cover_infos, :capa_detalhe_w, :integer
  	add_column :cover_infos, :capa_detalhe_h, :integer
  end
end
