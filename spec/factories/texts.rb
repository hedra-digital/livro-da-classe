# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :text do
    book { create(:book)}
    content "MyString"
    title "MyString"
    uuid "MyString"
  end
end
