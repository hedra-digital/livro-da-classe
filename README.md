Livro da Classe
===============

Requirements

* Ruby 1.9.3
* Git

# Linux setup guide

1) Generate a SSH private key

	assh-keygen -t rsa -C "your_email@youremail.com"

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