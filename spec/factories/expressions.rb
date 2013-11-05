# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :expression do
    target "MyString"
    replace "MyString"
  end
end
