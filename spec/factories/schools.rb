require 'faker'

FactoryGirl.define do
  factory :school do
    name { Faker::Company.name }
    state { Faker::Address.state }
    city { Faker::Address.city }
  end
end
