require 'faker'

FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Base.bothify('#?#?#?#?') }
    educator true
  end
end
