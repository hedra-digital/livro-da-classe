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

###Symlink LaTeX template directory

sudo ln -s /etc/texmf/tex/generic/ ~/apps/livrodaclasse/current/templates

###License

MIT License. Copyright 2012, 2013 Editora Hedra. http://hedra.com.br

###Passos para instalação

### Clonar a aplicação
<code>
$ git clone git@github.com/hedra-digital/livro-da-classe.git
</code>

### Instalar ruby
<code>
$ cd hedra-site
$ rvm install ruby-2.0.0-p247
</code>

### Criar gemset
<code>
$ rvm use ruby-2.0.0-p247
$ rvm gemset create ruby-2.0.0-p247 hedra-site
$ rvm use ruby-2.0.0-p247@hedra-site
</code>

### Instalar Gems do projeto
<code>
$ bundle install
</code>

sudo apt-get install libmagickwand-dev libmagickcore-dev imagemagick 
    
### Others 

sudo apt-get install libqt4-dev libqtwebkit-dev

### Configurar banco de dados da aplicação
<code>
$ cp config/database.example.yml config/database.yml
</code>

Configure usuário e senha de acesso ao MySQL no arquivo config/database.yml

### Configurações da aplicação
<code>
$ cp config/config.example.yml config/config.yml
</code>

### Configurações do LateX
<code>
$ cd /etc/texmf/tex/generic/
$ sudo ln -s [PASTA DA APLICAÇÃO]/templates/ latex
</code>

Configure usuário e senha de acesso a area restrita e pasta dos templates no arquivo config/config.ym

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
