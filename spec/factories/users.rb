require 'faker'

FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Base.bothify('#?#?#?#?') }
    asked_for_email true

    factory :organizer do
      organized_books { FactoryGirl.create_list(:book, 3) }
    end

    factory :collaborator do
      books { FactoryGirl.build_list(:book, 3) }
    end
  end
end
