require 'faker'

FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Base.bothify('#?#?#?#?') }
    asked_for_email true
  end

  factory :organizer, :parent => :user do
    books { FactoryGirl.build_list(:book, 3) }
  end
end
