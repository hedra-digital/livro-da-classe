class AddCropColumnsToCoverInfo < ActiveRecord::Migration
  def change
  	add_column :cover_infos, :logo_x1, :integer
  	add_column :cover_infos, :logo_x2, :integer
  	add_column :cover_infos, :logo_y1, :integer
  	add_column :cover_infos, :logo_y2, :integer

  	add_column :cover_infos, :capa_imagem_x1, :integer
  	add_column :cover_infos, :capa_imagem_x2, :integer
  	add_column :cover_infos, :capa_imagem_y1, :integer
  	add_column :cover_infos, :capa_imagem_y2, :integer

  	add_column :cover_infos, :capa_detalhe_x1, :integer
  	add_column :cover_infos, :capa_detalhe_x2, :integer
  	add_column :cover_infos, :capa_detalhe_y1, :integer
  	add_column :cover_infos, :capa_detalhe_y2, :integer
  end
end
