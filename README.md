## Como configurar o ambiente de desenvolvimento

### Pré requisitos
* Git (http://git-scm.com/)
* RVM (https://rvm.io/rvm/install)
* MySQL (http://www.mysql.com/)

[![Build Status](https://travis-ci.org/hedra-digital/livro-da-classe.png)](https://travis-ci.org/hedra-digital/livro-da-classe) [![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/hedra-digital/livro-da-classe)

### Install Texlive

sudo apt-get texlive-full

### Install ImageMagick

sudo apt-get install libmagickwand-dev libmagickcore-dev imagemagick 

###Others

sudo apt-get install libqt4-dev libqtwebkit-dev

###License

MIT License. Copyright 2012, 2013 Editora Hedra. http://hedra.com.br

###Passos para instalação

### Clonar a aplicação
<code>
$ git clone git@github.com/hedra-digital/livro-da-classe.git
</code>

### Instalar ruby
<code>
$ cd livro-da-classe
$ rvm install ruby-2.0.0-p247
</code>

### Criar gemset
<code>
$ rvm use ruby-2.0.0-p247
$ rvm gemset create ruby-2.0.0-p247 livro-da-classe
$ rvm use ruby-2.0.0-p247@livro-da-classe
</code>

### Instalar Gems do projeto
<code>
$ bundle install
</code>

### Configurar banco de dados da aplicação
<code>
$ cp config/database.example.yml config/database.yml
</code>

Configure usuário e senha de acesso ao MySQL no arquivo config/database.yml

### Configurações da aplicação
<code>
$ cp config/config.example.yml config/config.yml
</code>

### Instalação PDF Latex
<code>
$ sudo apt-get install pdflatex
</code>

### Instalação Inkscape
<code>
$ sudo apt-get install inkscape
</code>

### Instalação Pandoc (versão 1.10.1)
<code>
$ sudo apt-get install pandoc
</code>

Configure usuário e senha de acesso a area restrita e pasta dos templates no arquivo config/config.yml

### Setar repositório para o submodulo dos projetos

Definir e iniciar um repositório git e colocar seu caminho na variável "books_submodule_path" do arquivo de configurações.

### Criar estrutura do banco de dados da aplicação
<code>
$ rake db:create
$ rake db:migrate
</code>

### Executar aplicação local
<code>
$ rails server
</code>

Acesse a aplicação através da url http://127.0.0.1:3000
