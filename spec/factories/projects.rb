# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    book_id ""
    release_date 3.months.since
    finish_date 3.months.since - 2.weeks
  end
end
