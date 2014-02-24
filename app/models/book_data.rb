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
                  :capainteira,

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
                  :numeroedicao,

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
                  :grafica,
                  :papelmiolo,


                  #Metadados
                  :palavraschave,

                  #Ebook
                  :publicaebook

  belongs_to                :book

  validates_numericality_of     :numeroedicao, :greater_than_or_equal_to => 1, :less_than_or_equal_to=>100

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

  has_attached_file :capainteira,
                    :url => "/system/:class/:attachment/:id_partition/:style/Capa.:extension",
                    :styles => {
                      :content => ['100%', :jpg],
                      :thumb => ['60x80>', :jpg]
                    }

  def get_fullpath_for url
    if !url.index("?").nil?
      url = url[0..url.index("?") -1]
    end
    Rails.public_path + url
  end

  def cover_directory
    if self.capainteira.exists? 
      File.dirname(self.capainteira.path)
    elsif self.book.cover.exists?
      File.dirname(self.book.cover.path)
    else
      nil
    end
  end

  def check value, field, is_image=false
    (field.blank? or (is_image && !field.exists?)) ? "" : value
  end   

  def to_latex content
    LatexConverter.to_latex(content)
  end

  def to_file
    commands = "% Gerais\n"
    commands << check("\\newcommand{\\titulo}{#{self.book.title}}\n", self.book.title)
    commands << check("\\newcommand{\\subtit}{#{self.subtit}}\n", self.subtit)
    commands << check("\\newcommand{\\autor}{#{self.autor}}\n", self.autor)
    commands << check("\\newcommand{\\titcabeco}{#{self.sumariotitulo}}\n", self.sumariotitulo)
    commands << check("\\newcommand{\\autorcabeco}{#{self.sumarioautor}}\n", self.sumarioautor)
    commands << check("\\newcommand{\\organizador}{#{self.organizador}}\n", self.organizador)
    commands << check("\\newcommand{\\introdutor}{#{self.introdutor}}\n", self.introdutor)
    commands << check("\\newcommand{\\tradutor}{#{self.tradutor}}\n", self.tradutor)
    commands << "\n% Capa\n"
    commands << check("\\newcommand{\\orelha}{#{self.orelha}}\n", self.orelha)
    commands << check("\\newcommand{\\quartacapa}{#{self.quartacapa}}\n", self.quartacapa)
    commands << check("\\newcommand{\\dircapa}{#{self.cover_directory}}\n", self.cover_directory)
    commands << "\n% Página de créditos\n"
    commands << check("\\newcommand\\copyrightlivro{#{self.copyrightlivro}}\n", self.copyrightlivro)
    commands << check("\\newcommand\\copyrighttraducao{#{self.copyrighttraducao}}\n", self.copyrighttraducao)
    commands << check("\\newcommand\\copyrightorganizacao{#{self.copyrightorganizacao}}\n", self.copyrightorganizacao)
    commands << check("\\newcommand\\copyrightilustracao{#{self.copyrightilustracao}}\n", self.copyrightilustracao)
    commands << check("\\newcommand\\copyrightintroducao{#{self.copyrightintroducao}}\n", self.copyrightintroducao)
    commands << check("\\newcommand\\titulooriginal{#{self.titulooriginal}}\n", self.titulooriginal)
    commands << check("\\newcommand\\edicaoconsultada{#{self.edicaoconsultada}}\n", self.edicaoconsultada)
    commands << check("\\newcommand\\primeiraedicao{#{self.primeiraedicao}}\n", self.primeiraedicao)
    commands << check("\\newcommand\\agradecimentos{#{self.agradecimentos}}\n", self.agradecimentos)
    commands << check("\\newcommand\\indicacao{#{self.indicacao}}\n", self.indicacao)
    commands << check("\\newcommand\\ISBN{#{self.isbn}}\n", self.isbn)
    commands << check("\\newcommand\\ano{#{self.ano}}\n", self.ano)
    commands << check("\\newcommand\\edicao{#{self.edicao}}\n", self.edicao)
    commands << check("\\newcommand\\coedicao{#{self.coedicao}}\n", self.coedicao)
    commands << check("\\newcommand\\assistencia{#{self.assistencia}}\n", self.assistencia)
    commands << check("\\newcommand\\revisao{#{self.revisao}}\n", self.revisao)
    commands << check("\\newcommand\\preparacao{#{self.preparacao}}\n", self.preparacao)
    commands << check("\\newcommand\\capa{#{self.capa}}\n", self.capa)
    commands << check("\\newcommand\\imagemcapa{#{self.imagemcapa}}\n", self.imagemcapa)
    commands << check("\\newcommand\\numeroedicao{#{self.numeroedicao}}\n", self.numeroedicao)    
    commands << "\n% Ficha catalográfica\n"
    commands << check("\\newcommand\\imagemficha{#{get_fullpath_for(self.imagemficha.url)}}\n", self.imagemficha, true)
    commands << "\n% Parceiro\n"
    commands << check("\\newcommand\\instituicao{#{self.instituicao}}\n", self.instituicao)
    commands << check("\\newcommand\\logradouro{#{self.logradouro}}\n", self.logradouro)
    commands << check("\\newcommand\\numero{#{self.numero}}\n", self.numero)
    commands << check("\\newcommand\\cidadeinstituicao{#{self.cidadeinstituicao}}\n", self.cidadeinstituicao)
    commands << check("\\newcommand\\estado{#{self.estado}}\n", self.estado)
    commands << check("\\newcommand\\cep{#{self.cep}}\n", self.cep)
    commands << check("\\newcommand\\diretor{#{self.diretor}}\n", self.diretor)
    commands << check("\\newcommand\\coordenador{#{self.coordenador}}\n", self.coordenador)
    commands << check("\\newcommand\\turma{#{self.turma}}\n", self.turma)
    commands << check("\\newcommand\\logo{#{get_fullpath_for(self.logo.url)}}\n", self.logo, true)
    commands << check("\\newcommand\\cidade{#{self.cidade}}\n", self.cidade)
    commands << "\n% Aparatos\n"
    commands << check("\\newcommand\\release{#{to_latex(self.release)}}\n", self.release)
    commands << check("\\newcommand\\trechotexto{#{to_latex(self.trechotexto)}}{\\lipsum}\n", self.trechotexto)
    commands << check("\\newcommand\\sobreobra{#{to_latex(self.sobreobra)}}\n", self.sobreobra)
    commands << check("\\newcommand\\sobreautor{#{to_latex(self.sobreautor)}}\n", self.sobreautor)
    commands << check("\\newcommand\\sobreorganizador{#{to_latex(self.sobreorganizador)}}\n", self.sobreorganizador)
    commands << check("\\newcommand\\sobretradutor{#{to_latex(self.sobretradutor)}}\n", self.sobretradutor)
    commands << "\n% Informações técnicas\n"
    commands << check("\\newcommand\\dimensao{#{self.dimensao}}\n", self.dimensao)
    commands << check("\\newcommand\\peso{#{self.peso}}\n", self.peso)
    commands << check("\\newcommand\\gramaturamiolo{#{self.gramaturamiolo}}\n", self.gramaturamiolo)
    commands << check("\\newcommand\\cormiolo{#{self.cormiolo}}\n", self.cormiolo)
    commands << check("\\newcommand\\grafica{#{self.grafica}}\n", self.grafica)
    commands << check("\\newcommand\\papelmiolo{#{self.papelmiolo}}\n", self.papelmiolo)    
    commands << "\n% Metadados\n"
    commands << check("\\newcommand\\palavraschave{#{self.palavraschave}}\n", self.palavraschave)
    commands << "\n% ebook\n"
    commands << check("\\newcommand\\publicaebook{#{self.publicaebook}}\n", self.publicaebook)
    commands
  end
end
