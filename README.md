Livro da Classe
===============

Requirements

* Ruby 1.9.3
* Git


# Core tools setup guide (Linux)

1) Install needed tools

	sudo apt-get install build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison subversion mysql-client mysql-server libmysql-ruby libmysqlclient-dev postgresql postgresql-contrib libpq-dev nodejs

2) Install RVM and Ruby

	curl -L https://get.rvm.io | bash -s stable --ruby

3) Configure initialization

	echo '[[ -s "~/.rvm/scripts/rvm" ]] && source "~/.rvm/scripts/rvm"' >> ~/.bashrc
	source ~/.bashrc

4) Configure PostgreSQL
	sudo su - postgres
	psql -d postgres -U postgres
		postgres=# alter user postgres with password 's0meth1ng'; ALTER ROLE
		postgres=# \q
	sudo /etc/init.d/postgresql restart


# Clone git repository and Rails setup guide

1) Generate a SSH private key

	ssh-keygen -t rsa -C "your_email@youremail.com"

2) Copy your key to the clipboard

	sudo apt-get install xclip
	xclip -sel clip < ~/.ssh/id_rsa.pub

3) Paste it in your Github profile, under 'Account Settings'

4) Config Git with your personal data

	git config --global user.name "Your Name"
	git config --global user.email your.email@example.com

5) Create a directory and initialize Git

	mkdir livro-da-classe
	cd livro-da-classe
	git init

6) Add this remote repository

	git remote add origin git@github.com:hedra-digital/livro-da-classe.git

7) Download all current project files

	git pull