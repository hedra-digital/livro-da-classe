
Profile.create(:desc => "Usuário")
Profile.create(:desc => "Admin")
Profile.create(:desc => "Publisher")

BookStatus.create(:desc => "Em fila")
BookStatus.create(:desc => "Aprovado")
BookStatus.create(:desc => "Em impressão")

User.create(name: "Admin", email: "admin@example.com", password: "password", profile: Profile.find(2))
