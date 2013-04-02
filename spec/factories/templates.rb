# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :template do
    books { [build_stubbed(:book), build_stubbed(:book)] }
    name { Faker::Lorem.sentence }
  end
end
