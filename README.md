#Livro da Classe & Tipografia Digital

## Como configurar o ambiente de desenvolvimento

### Pré requisitos
* Vagrant (http://www.vagrantup.com)

### Clonar a aplicação
<code>
$ git clone git@github.com/hedra-digital/livro-da-classe.git
</code>

### Iniciar Vagrant
<code>
$ vagrant up
$ vagrant ssh
$ cd /project
</code>

### Instalar Gemas do projeto
<code>
$ bundle install
</code>

### Configurações da aplicação
<code>
$ cp config/config.example.yml config/config.yml
</code>

### Configurações para o submodulo dos projetos

Definir e iniciar um repositório git e colocar seu caminho na variável "books_submodule_path" do arquivo de configurações (config/config.yml)

Mais informações sobre git-submodules (http://git-scm.com/docs/git-submodule)

### Configurando templates LaTeX

1. Coloque a pasta de templates dentro da pasta da aplicação;
2. Dentro do vagrant, coloque a pasta de templates no lugar desejado;
3. Ajuste no arquivo de configurações o caminho do templates.

### Criar estrutura do banco de dados da aplicação

<code>
$ rake db:create
$ rake db:migrate
</code>

### Executar aplicação local

<code>
$ rails server
</code>

Acesse a aplicação através da url http://127.0.0.1:3012

###License

MIT License. Copyright 2012, 2013, 2014 Editora Hedra. http://hedra.com.br