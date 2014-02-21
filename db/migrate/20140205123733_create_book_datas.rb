class CreateBookDatas < ActiveRecord::Migration
  create_table :book_datas do |t|
      t.references :book

      t.string  :subtit
      t.string  :autor
      t.string  :sumariotitulo
      t.string  :sumarioautor
      t.string  :organizador
      t.string  :introdutor
      t.string  :tradutor

      #Capa
      t.text  :orelha
      t.text  :quartacapa

      #Página de Créditos
      t.string  :copyrightlivro
      t.string  :copyrighttraducao
      t.string  :copyrightorganizacao
      t.string  :copyrightilustracao
      t.string  :copyrightintroducao
      t.string  :titulooriginal
      t.string  :edicaoconsultada
      t.string  :primeiraedicao
      t.string  :agradecimentos
      t.string  :indicacao
      t.string  :isbn
      t.string  :ano
      t.string  :edicao
      t.string  :coedicao
      t.string  :assistencia
      t.string  :revisao
      t.string  :preparacao
      t.string  :capa
      t.string  :imagemcapa

      #Ficha Catalografica
      t.attachment  :imagemficha

      #Parceiro
      t.string  :instituicao
      t.string  :logradouro
      t.string  :numero
      t.string  :cidadeinstituicao
      t.string  :estado
      t.string  :cep
      t.string  :diretor
      t.string  :coordenador
      t.string  :turma
      t.string  :quartacapa
      t.attachment  :logo
      t.string  :cidade

      #Aparatos
      t.text  :release
      t.text  :trechotexto
      t.text  :sobreobra
      t.text  :sobreautor
      t.text  :sobreorganizador
      t.text  :sobretradutor
      t.text  :resumo

      #Informações Técnicas
      t.string  :dimensao
      t.string  :peso
      t.string  :gramaturamiolo
      t.string  :cormiolo

      #Metadados
      t.string  :palavraschave

      #Ebook
      t.boolean  :publicaebook
      
      t.timestamps
    end
end
