require 'faker'

FactoryGirl.define do
  factory :text do
    title { Faker::Lorem.sentence }
    uuid "MyString"
    content { Faker::Lorem.paragraph }
    book { build_stubbed(:book) }
  end
end
