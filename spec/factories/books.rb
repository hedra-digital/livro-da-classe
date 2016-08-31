require 'faker'

FactoryGirl.define do
  factory :book do
    published_at "2013-01-16 23:33:21"
    title { Faker::Lorem.sentence }
    uuid "6ce94f7e-2c64-a1df-e9d6-a1211491ad72"
    subtitle { Faker::Lorem.sentence }
    organizers "MyText"
    directors "MyText"
    coordinators "MyText"
    template "aprimeiraopcao"
    association :organizer, :factory => :user
    association :book_data

    factory :book_with_texts do
      ignore do
        texts_count 5
      end

      after(:create) do |book, evaluator|
        FactoryGirl.create_list(:text, evaluator.texts_count, book: book)
      end
    end

    factory :book_with_users, :class => Book do
      users { [build_stubbed(:user), build_stubbed(:user)] }
    end
  end
end
