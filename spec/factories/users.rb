require 'faker'

FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password_digest "password"
    educator true
  end
end
