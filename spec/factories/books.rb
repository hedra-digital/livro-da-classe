# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :book do
    published_at "2013-01-16 23:33:21"
    title "MyString"
    uuid "6ce94f7e-2c64-a1df-e9d6-a1211491ad72"
    subtitle "MyString"
    organizers "MyText"
    directors "MyText"
    coordinators "MyText"
    organizer { create(:user) }
  end
end
