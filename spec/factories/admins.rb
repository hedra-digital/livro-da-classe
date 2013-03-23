# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin do
    email "MyString"
    password_digest "MyString"
  end
end
