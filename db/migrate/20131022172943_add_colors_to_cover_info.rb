class AddColorsToCoverInfo < ActiveRecord::Migration
  def change
  	add_column :cover_infos, :cor_primaria, :string
  	add_column :cover_infos, :cor_secundaria, :string
  end
end
