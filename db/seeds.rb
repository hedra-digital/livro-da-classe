# encoding: UTF-8

user = Profile.create(:desc => "Usuário")
admin = Profile.create(:desc => "Admin")

BookStatus.create(:desc => "Em fila")
BookStatus.create(:desc => "Aprovado")
BookStatus.create(:desc => "Em impressão")
