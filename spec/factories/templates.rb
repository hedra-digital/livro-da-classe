require 'faker'

FactoryGirl.define do
  factory :template do
    name { Faker::Lorem.sentence }
  end
end
