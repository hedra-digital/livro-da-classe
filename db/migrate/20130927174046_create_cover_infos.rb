class CreateCoverInfos < ActiveRecord::Migration
  def change
    create_table :cover_infos do |t|
      t.references :book
      t.string :titulo_linha1
      t.string :titulo_linha2
      t.string :titulo_linha3
      t.string :organizador
      t.string :autor
      t.string :texto_na_lombada

      t.timestamps
    end
  end
end
