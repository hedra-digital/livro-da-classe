# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :client do
    user
    position "MyString"
    phone "MyString"
    company "MyString"
  end
end
