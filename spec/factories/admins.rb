require 'faker'

FactoryGirl.define do
  factory :admin do
    email { Faker::Internet.email }
    password { Faker::Base.bothify('#?#?#?#?') }
  end
end
