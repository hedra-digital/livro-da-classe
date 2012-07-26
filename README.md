Livro da Classe
===============

# Linux setup guide

1) Generate a SSH private key

  ssh-keygen -t rsa -C "your_email@youremail.com"

2) Copy your key to the clipboard

  sudo apt-get install xclip
  xclip -sel clip < ~/.ssh/id_rsa.pub

3) Paste it in your Github profile, under 'Account Settings'

4) Create a directory and initialize Git

  mkdir livro-da-classe
  cd livro-da-classe
  git init

5) Add this remote repository

  git remote add origin git@github.com:hedra-digital/livro-da-classe.git

6) Download all current project files

  git pull