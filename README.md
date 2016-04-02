[![Build Status](https://travis-ci.org/hedra-digital/livro-da-classe.png)](https://travis-ci.org/hedra-digital/livro-da-classe)
[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/hedra-digital/livro-da-classe)
[![Code Climate](https://codeclimate.com/repos/536c079f6956801268001034/badges/b8197b1c251d7246d52e/gpa.png)](https://codeclimate.com/repos/536c079f6956801268001034/feed)

#Livro da Classe & Tipografia Digital

## Como configurar o ambiente de desenvolvimento

### Pré requisitos
* Vagrant (http://www.vagrantup.com)

### Clonar a aplicação
<code>
$ git clone https://github.com/hedra-digital/livro-da-classe.git
</code>

### Criar Vagrantfile
Dentro do diretório da aplicação:
<code>
$ cp Vagrantfile.example Vagrantfile
</code>

### Configurações da aplicação
<code>
$ cp config/config.example.yml config/config.yml

$ cp config/database.example.yml config/database.yml
</code>

### Configurações para o Submodulo

Clonar a pasta do submodulo de desenvolvimento.

<code>
$ git clone https://bitbucket.org/tipografiadigital/tipografia-submodule-dev
</code>

Adicionar a pasta na configuração do vagrant (Vagrantfile)

<code>
  config.vm.synced_folder "/local-submodule-path", "/submodule-path"
</code>

Colocar seu caminho na variável "books_submodule_path" do arquivo de configurações (config/config.yml)

### Configurações para o armazenamento dos livros

Criar outra pasta local para armazenar os livros criados pela aplicação.

<code>
$ mkdir books
</code>

Adicionar a pasta na configuração do vagrant (Vagrantfile)

<code>
  config.vm.synced_folder "/local-books-path", "/books"
</code>

Colocar seu caminho na variável "books_path" do arquivo de configurações (config/config.yml)

### Configurações para o ambiente LaTeX

Clonar a projeto do texmf.

<code>
$ git clone https://github.com/hedra-digital/latex.git texmf && cd texmf && git checkout td-producao-texmf
</code>

Adicionar a pasta na configuração do vagrant (Vagrantfile)

<code>
  config.vm.synced_folder "/local-latex-texmf", "/texmf"
</code>

### Configurações para o template LaTeX

Clonar a projeto do texmf.

<code>
$ git clone https://github.com/hedra-digital/latex.git templates && cd templates && git checkout td-producao
</code>

Adicionar a pasta na configuração do vagrant (Vagrantfile)

<code>
  config.vm.synced_folder "/local-templates", "/templates"
</code>

Colocar seu caminho na variável "templates_path" do arquivo de configurações (config/config.yml)

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

### Criar estrutura do banco de dados da aplicação

<code>
$ rake db:create
$ rake db:migrate
$ rake db:seed
</code>

### Executar aplicação local

<code>
$ rails server
</code>

Acesse a aplicação através da url http://127.0.0.1:3012

###License

MIT License. Copyright 2012, 2013, 2014 Editora Hedra. http://hedra.com.br
