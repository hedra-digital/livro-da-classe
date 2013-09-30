class ChangeCoverInfo < ActiveRecord::Migration
  def up
    remove_column :cover_infos, :organizador 
    remove_column :cover_infos, :texto_na_lombada 
    add_column :cover_infos, :texto_quarta_capa, :string 
  end

  def down
    add_column :cover_infos, :organizador, :string 
    add_column :cover_infos, :texto_na_lombada, :string
    remove_column :cover_infos, :texto_quarta_capa 
  end
end
