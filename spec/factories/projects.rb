# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    book
    client
    release_date 3.months.since.to_date
    quantity 100
    publish_format "21 x 14 cm"
  end
end
