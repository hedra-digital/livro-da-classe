require 'faker'

FactoryGirl.define do
  factory :text do
    book
    user
    title { Faker::Lorem.sentence }
    uuid "6ce94f7e-2c64-a1df-e9d6-a1211491ad72"
    content { Faker::Lorem.paragraph }
  end
end
