# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :capa do
    book_id 1
    titulo_linha1 "MyString"
    titulo_linha2 "MyString"
    titulo_linha3 "MyString"
    organizador "MyString"
    autor "MyString"
    texto_na_lombada "MyString"
  end
end
