class BookData < ActiveRecord::Base

  attr_accessible :subtit,
                  :autor,
                  :sumariotitulo,
                  :sumarioautor,
                  :organizador,
                  :introdutor,
                  :tradutor,

                  #Capa
                  :orelha,
                  :quartacapa,
                  :capaimagem,
                  :capadetalhe,

                  #Página de Créditos
                  :copyrightlivro,
                  :copyrighttraducao,
                  :copyrightorganizacao,
                  :copyrightilustracao,
                  :copyrightintroducao,
                  :titulooriginal,
                  :edicaoconsultada,
                  :primeiraedicao,
                  :agradecimentos,
                  :indicacao,
                  :isbn,
                  :ano,
                  :edicao,
                  :coedicao,
                  :assistencia,
                  :revisao,
                  :preparacao,
                  :capa,
                  :imagemcapa,

                  #Ficha Catalografica
                  :imagemficha,

                  #Parceiro
                  :instituicao,
                  :logradouro,
                  :numero,
                  :cidadeinstituicao,
                  :estado,
                  :cep,
                  :diretor,
                  :coordenador,
                  :turma,
                  :quartacapa,
                  :logo,
                  :cidade,

                  #Aparatos
                  :release,
                  :trechotexto,
                  :sobreobra,
                  :sobreautor,
                  :sobreorganizador,
                  :sobretradutor,
                  :resumo,

                  #Informações Técnicas
                  :dimensao,
                  :peso,
                  :gramaturamiolo,
                  :cormiolo,

                  #Metadados
                  :palavraschave,

                  #Ebook
                  :publicaebook

      belongs_to                :book

      has_attached_file :logo,
                        :styles => {
                              :normal => ["600x600>", :png],
                              :small => ["300x300#", :png]
                        }

      has_attached_file :imagemficha,
                        :styles => {
                              :normal => ["600x600>", :png],
                              :small => ["300x300#", :png]
                        }

end
