require 'faker'

FactoryGirl.define do
  factory :book_data do
  	autor { Faker::Name.name }
  end
end